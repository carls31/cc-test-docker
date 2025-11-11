# main.py - test imports and print Done
import sys

modules = [
    "numpy",
    "pandas",
    "geopandas",
    "matplotlib",
    "rasterio",
    # "gdal",
    "shapely"
]

failed = []
for m in modules:
    try:
        __import__(m)
        print(f"Imported {m}")
    except Exception as e:
        failed.append((m, str(e)))

if failed:
    print("\nSome imports failed:", file=sys.stderr)
    for m, err in failed:
        print(f"- {m}: {err}", file=sys.stderr)
    sys.exit(1)

print("\nDone")
