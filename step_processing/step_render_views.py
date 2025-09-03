
from pathlib import Path
import argparse
from cadquery import exporters, importers

def export_svg(obj, out_svg: Path, projection_dir, stroke_width=1, show_hidden=False):
    opts = {
        "projectionDir": projection_dir,
        "showAxes": False,
        "showHidden": show_hidden,
        "strokeWidth": stroke_width,
    }
    exporters.export(obj, str(out_svg), opt=opts)


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
