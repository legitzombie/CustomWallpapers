import requests
from pathlib import Path

current_folder = Path(__file__).resolve().parent
parent_folder = current_folder.parent

def safe_path(p: Path):
    return str(p).replace("\\", "\\\\")

icon_folder = safe_path(parent_folder / "temp" / "images")
output_folder = safe_path(parent_folder / "temp" / "raw" / "base" / "customwallpapers" )
atlas_name = "customwallpapers"

url = "https://raw.githubusercontent.com/DoctorPresto/Cyberpunk-Helper-Scripts/main/generate_inkatlas.py"
response = requests.get(url)
if response.status_code != 200:
    raise Exception(f"Failed to download file: HTTP {response.status_code}")
lines = response.text.splitlines()

modified_lines = []
for line in lines:
    stripped = line.lstrip()
    indent = line[:len(line) - len(stripped)]

    if "atlas_name = os.getenv(" in stripped:
        modified_lines.append(f'{indent}atlas_name = "{atlas_name}"')
    elif "icon_folder = icon_folder or input(" in stripped:
        modified_lines.append(f'{indent}icon_folder = "{icon_folder}"')
    elif "output_folder = output_folder or input(" in stripped:
        modified_lines.append(f'{indent}output_folder = "{output_folder}"')
    else:
        modified_lines.append(line)

output_file = current_folder / "generate_inkatlas.py"
with open(output_file, "w", encoding="utf-8") as f:
    f.write("\n".join(modified_lines) + "\n") 
