{ home }:
{
  paths = [
    "${home}/70_collections"
    "${home}/80_archive"
  ];

  excludes = [
    # Cryptomator plaintext views
    "${home}/70_collections/03_personal-records/01_content"
    "${home}/70_collections/04_work-records/01_content"

    # Volatile/generated directories
    "**/__pycache__"
    "**/.mypy_cache"
    "**/.pytest_cache"
    "**/.ruff_cache"
    "**/.cache"
    "**/.venv"
    "**/node_modules"
    "**/.debris"
  ];
}
