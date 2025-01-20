import platform
from pathlib import Path
import subprocess


def sync_files(source_dir: Path, target_dir: Path):
    """Копирует или создает симлинки для файлов из source_dir в target_dir."""
    for item in source_dir.iterdir():
        dest = target_dir / item.name
        if item.is_dir():
            dest.mkdir(parents=True, exist_ok=True)
            sync_files(item, dest)
        else:
            print(f"Linking {item} -> {dest}")
            if dest.exists():
                dest.unlink()
            dest.symlink_to(item)


def setup_common():
    """Применяет общие файлы конфигурации."""
    print("Applying common configurations...")
    common_dir = Path(__file__).parent.parent / "dotfiles" / "common"
    sync_files(common_dir, Path.home())


def setup_macos():
    """Применяет конфигурации для macOS."""
    print("Setting up macOS...")
    macos_dir = Path(__file__).parent.parent / "dotfiles" / "macos"
    sync_files(macos_dir, Path.home())
    subprocess.run(["sh", str(macos_dir / "brew.sh")], check=True)


def setup_linux():
    """Применяет конфигурации для Linux."""
    print("Setting up Linux...")
    linux_dir = Path(__file__).parent.parent / "dotfiles" / "linux"
    sync_files(linux_dir, Path.home())
    subprocess.run(["sh", str(linux_dir / "apt-setup.sh")], check=True)


def setup_windows():
    """Применяет конфигурации для Windows."""
    print("Setting up Windows...")
    windows_dir = Path(__file__).parent.parent / "dotfiles" / "windows"
    subprocess.run(["powershell", "-NoProfile", "-ExecutionPolicy", "Bypass", "-File", str(windows_dir / "bootstrap.ps1")], check=True)


def main():
    os_name = platform.system()

    setup_common()

    if os_name == "Darwin":
        setup_macos()
    elif os_name == "Linux":
        setup_linux()
    elif os_name == "Windows":
        setup_windows()
    else:
        print(f"Unsupported OS: {os_name}")


if __name__ == "__main__":
    main()
