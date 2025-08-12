#!/usr/bin/env python3

from pathlib import Path
import argparse
import cadquery as cq
from cadquery import exporters, importers

# try:
#     import cairosvg
#     HAS_CAIROSVG = True
# except Exception:
#     HAS_CAIROSVG = False

def export_svg(obj, out_svg: Path, projection_dir, stroke_width=0.5, show_hidden=False):
    opts = {
        "projectionDir": projection_dir,
        "showAxes": False,
        "showHidden": show_hidden,
        "strokeWidth": stroke_width,
        # "strokeColor": (0, 0, 0),
        # "hiddenColor": (150, 150, 150),
        # "width": 1024, "height": 1024,
    }
    exporters.export(obj, str(out_svg), opt=opts)


# def svg_to_png(svg_path: Path, png_path: Path, dpi=192):
#     import cairosvg
#     cairosvg.svg2png(url=str(svg_path), write_to=str(png_path), dpi=dpi)


def main():
    parser = argparse.ArgumentParser(description="Render iso/front/top views from a step file")
    parser.add_argument("step_path", type=Path, help="Path to .step file")
    args = parser.parse_args()

    step_path: Path = args.step_path
    if not step_path.exists():
        parser.error(f"Path not found: {step_path}")

    if step_path.suffix.lower() not in {".step", ".stp"}:
        parser.error(f"Not a step file")



    out_dir = Path(__file__).parent/"render_cache"
    out_dir.mkdir(parents=True, exist_ok=True)
    base = step_path.stem  #filename without extension

    shape = importers.importStep(str(step_path))

    iso_svg   = out_dir / f"{base}_iso.svg"
    front_svg = out_dir / f"{base}_front.svg"
    top_svg   = out_dir / f"{base}_top.svg"

    export_svg(shape, iso_svg,   projection_dir=(1, 1, 1))
    export_svg(shape, front_svg, projection_dir=(0, -1, 0))
    export_svg(shape, top_svg,   projection_dir=(0, 0, -1))

    print("Wrote SVGs:")
    print(" ", iso_svg)
    print(" ", front_svg)
    print(" ", top_svg)

    # dpi=192
    # if HAS_CAIROSVG:
    #     iso_png   = out_dir / f"{base}_iso.png"
    #     front_png = out_dir / f"{base}_front.png"
    #     top_png   = out_dir / f"{base}_top.png"

    #     svg_to_png(iso_svg, iso_png, dpi)
    #     svg_to_png(front_svg, front_png, dpi)
    #     svg_to_png(top_svg, top_png, dpi)

    #     print(f"Wrote PNGs (via CairoSVG @ {dpi} dpi):")
    #     print(" ", iso_png)
    #     print(" ", front_png)
    #     print(" ", top_png)
    # else:

if __name__ == "__main__":
    main()
