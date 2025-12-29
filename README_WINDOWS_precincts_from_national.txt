TX-38 VTD + Precincts (from national) - Local Map (Windows)

How to run:
1) Unzip the package to a folder
2) Double-click START_MAP_WINDOWS.bat
3) Your default browser should open at:
   http://localhost:8000/index_precincts_targeting.html

Controls:
- VTD color by: changes the VTD thematic layer.
- Show precincts: overlays precinct polygons selected from the full Precincts24G shapefile
  using an INTERSECTS filter against the VTD footprint (NO clipping).
- Precinct color by: choose Target voters / Target households / Priority bucket / Has targeting.
- Show layer footprints: shows two outlines on top:
    Blue dashed = VTD footprint
    Red solid  = Precinct footprint (from selected precincts)

Files:
- index_precincts_targeting.html
- tx38_vtd_map.geojson
- tx38_precincts_from_national_targeting.geojson
- tx38_vtd_footprint.geojson
- tx38_precincts_footprint.geojson
- serve.ps1
- START_MAP_WINDOWS.bat
