import platform
import os
import subprocess
from pathlib import Path

def sync_files(source_dir: Path, home_dir: Path, excludes: list):
    """Синхронизирует файлы из source_dir в home_dir, исключая файлы из excludes."""
    for item in source_dir.iterdir():
        if item.name in excludes:
            continue
        dest = home_dir / item.name
        if dest.exists():
            print(f"Overwriting: {dest}")
        else:
            print(f"Copying: {item} -> {dest}")
        if item.is_dir():
            subprocess.run(["rsync", "-avh", "--no-perms", str(item) + "/", str(dest)])
        else:
            dest.write_text(item.read_text())


def setup_macos(source_dir: Path):
    print("Setting up for macOS...")
    home_dir = Path.home()
    sync_files(source_dir, home_dir, excludes=[".git/", ".DS_Store", "README.md", "LICENSE-MIT.txt", "bootstrap.sh"])
    subprocess.run(["source", str(home_dir / ".zshrc")])


def setup_linux(source_dir: Path):
    print("Setting up for Linux...")
    home_dir = Path.home()
    sync_files(source_dir, home_dir, excludes=[".git/", ".DS_Store", "README.md", "LICENSE-MIT.txt", "bootstrap.sh"])


def setup_windows(source_dir: Path):
    print("Setting up for Windows...")
    home_dir = Path.home()
    excludes = [".git/", ".gitignore", ".DS_Store", "README.md", "LICENSE-MIT.txt", "bootstrap.ps1"]
    sync_files(source_dir, home_dir, excludes)


def main():
    source_dir = Path(__file__).resolve().parent.parent
    os_name = platform.system()

    if os_name == "Darwin":
        setup_macos(source_dir)
    elif os_name == "Linux":
        setup_linux(source_dir)
    elif os_name == "Windows":
        setup_windows(source_dir)
    else:
        print(f"Unsupported OS: {os_name}")
        exit(1)


if __name__ == "__main__":
    main()
