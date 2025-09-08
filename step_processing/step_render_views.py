
from pathlib import Path
import argparse
from cadquery import exporters, importers
import xml.etree.ElementTree as ET
import math
import re
def crop_cadquery_svg(svg_path: Path):
    tree = ET.parse(svg_path)
    root = tree.getroot()

    # cadquery’s fixed canvas (no viewBox)
    vw = float(root.get("width", 800))
    vh = float(root.get("height", 240))

    # outer <g> holds the transform
    g = root.find(".//{http://www.w3.org/2000/svg}g")
    if g is None:
        return
    t = g.get("transform", "")

    # parse scale & translate (y can be negative)
    sx = sy = 1.0
    tx = ty = 0.0
    m = re.search(r"scale\(\s*([-\d.]+)(?:\s*,\s*([-\d.]+))?\s*\)", t)
    if m:
        sx = float(m.group(1))
        sy = float(m.group(2) or m.group(1))
    m = re.search(r"translate\(\s*([-\d.]+)(?:\s*,\s*([-\d.]+))?\s*\)", t)
    if m:
        tx = float(m.group(1))
        ty = float(m.group(2) or 0.0)

    # get nominal stroke width (fallback 1.0) and compute on-canvas pad
    def _try_float(x):
        try: return float(x)
        except: return None


    nominal = _try_float(g.get("stroke-width"))
    if nominal is None:
        # scan for any explicit stroke-width; take the max if present
        widths = [_try_float(e.get("stroke-width")) for e in root.findall(".//*[@stroke-width]")]
        widths = [w for w in widths if w is not None]
        nominal = max(widths) if widths else 1.0

    stroke_pad = max(abs(sx), abs(sy)) * nominal

    # pull all coordinate pairs from path d=...
    coords = []
    for path in root.findall(".//{http://www.w3.org/2000/svg}path"):
        d = path.get("d", "")
        for a, b in re.findall(r"([-\d.]+),([-\d.]+)", d):
            coords.append((float(a), float(b)))
    if not coords:
        return

    def bbox(pts):
        xs = [p[0] for p in pts]; ys = [p[1] for p in pts]
        return min(xs), min(ys), max(xs), max(ys)

    # two plausible orders (SVG transform order confusion insurance)
    A = [(sx*x + tx, sy*y + ty) for x, y in coords]         # scale then translate
    B = [(sx*(x + tx), sy*(y + ty)) for x, y in coords]     # translate then scale

    bbA = bbox(A); bbB = bbox(B)

    def overlap_score(bb):
        x0, y0, x1, y1 = bb
        ix0, iy0 = max(0, x0), max(0, y0)
        ix1, iy1 = min(vw, x1), min(vh, y1)
        return max(0, ix1 - ix0) * max(0, iy1 - iy0)

    chosen = bbA if overlap_score(bbA) >= overlap_score(bbB) else bbB
    x0, y0, x1, y1 = chosen

    # 1) add ink-safe margin first
    extra = 1.0  # bump to 1.2 if you want more breathing room
    pad = stroke_pad * extra
    x0 -= pad; y0 -= pad; x1 += pad; y1 += pad

    # 2) recompute width/height AFTER padding
    w = x1 - x0
    h = y1 - y0
    side = max(w, h)

    # 3) square-center using the UPDATED w/h
    if w < side:
        d = (side - w) / 2.0
        x0 -= d; x1 += d
    if h < side:
        d = (side - h) / 2.0
        y0 -= d; y1 += d

    # 4) write square viewBox + size
    root.attrib.pop("width", None)
    root.attrib.pop("height", None)
    root.set("viewBox", f"{x0} {y0} {side} {side}")
    root.set("width", str(side))
    root.set("height", str(side))

    tree.write(svg_path)

def export_svg(obj, out_svg: Path, projection_dir, stroke_width=1, show_hidden=False):
    opts = {
        "projectionDir": projection_dir,
        "showAxes": False,
        "showHidden": show_hidden,
        "strokeWidth": stroke_width,
        "fitView": True,
        "margin": 0
    }
    exporters.export(obj, str(out_svg), opt=opts)
    crop_cadquery_svg(out_svg)


def main():
    parser = argparse.ArgumentParser(description="Render iso/front/top views from a step file")
    parser.add_argument("step_path", type=Path, help="Path to .step file")
    parser.add_argument("out_dir",type=Path, help='Path to destination folder')
    args = parser.parse_args()

    step_path: Path = args.step_path
    if not step_path.exists():
        parser.error(f"Path not found: {step_path}")

    if step_path.suffix.lower() not in {".step", ".stp"}:
        parser.error(f"Not a step file")

    out_dir: Path = args.out_dir
    out_dir.mkdir(parents=True, exist_ok=True)

    shape = importers.importStep(str(step_path))

    iso_svg   = out_dir / f"iso.svg"
    front_svg = out_dir / f"front.svg"
    top_svg   = out_dir / f"top.svg"

    export_svg(shape, iso_svg,   projection_dir=(1, 1, 1))
    export_svg(shape, front_svg, projection_dir=(0, -1, 0))
    export_svg(shape, top_svg,   projection_dir=(0, 0, -1))

    print("Wrote SVGs:")
    print(" ", iso_svg)
    print(" ", front_svg)
    print(" ", top_svg)

if __name__ == "__main__":
    main()
