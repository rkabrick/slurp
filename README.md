# File Concatenator with Clipboard Copy

This tool is a Bash script that interactively allows you to select files from your project directory using [fzf](https://github.com/junegunn/fzf). It then concatenates the selected files—each preceded by a header showing its full path relative to the project root—and copies the resulting text to your clipboard. This is especially useful for quickly preparing content to paste into an LLM or any other application.

## Features

- **Interactive File Selection:**  
  Uses [fzf](https://github.com/junegunn/fzf) in multi-select mode with a custom key binding (`space:toggle`) so that you can select multiple files easily.

- **Concatenated Output with Headers:**  
  Each file’s content is preceded by a header displaying its relative path from the project root, making it clear which file each section belongs to.

- **Clipboard Integration:**  
  Automatically copies the final output to your clipboard using `pbcopy` (macOS), `xclip` or `wl-copy` (Linux).

- **Cross-Platform Compatibility:**  
  Designed to work on macOS and Linux, with easy customization if needed.

## Requirements

- **bash:** The script is written in Bash.
- **fzf:** For interactive file selection.  
  Installation instructions can be found on the [fzf GitHub page](https://github.com/junegunn/fzf#installation).

- **Clipboard Utility:**

  - **macOS:** `pbcopy` (pre-installed)
  - **Linux:** Either [`xclip`](https://github.com/astrand/xclip) or [`wl-copy`](https://github.com/bugaevc/wl-clipboard)  
    Install via your package manager, for example:

  ```bash
  sudo apt-get install xclip
  ```

  or

  ```bash
  sudo apt-get install wl-clipboard
  ```

- **Optional:**
  - [`bat`](https://github.com/sharkdp/bat) for file preview in fzf.

## Installation

1. **Clone or Download the Repository:**

   ```bash
   git clone https://your-repository-url.git
   cd your-repository-folder
   ```

2. **Ensure Dependencies Are Installed:**  
   Verify that `fzf` and your chosen clipboard utility (`pbcopy`, `xclip`, or `wl-copy`) are installed. Optionally install `bat` for file previews.

3. **Make the Script Executable:**
   ```bash
   chmod +x copy_files_to_clipboard.sh
   ```

## Usage

1. **Run the Script from the Project Root:**

   ```bash
   ./copy_files_to_clipboard.sh
   ```

2. **Select Files Interactively:**

   - Use the arrow keys to navigate the file list.
   - Press the **spacebar** to toggle selection. (The binding `space:toggle+down` ensures that after toggling, the cursor automatically moves down.)
   - Once you've selected all desired files, press **Enter**.

3. **Paste the Output:**
   - The script concatenates the files’ contents with headers showing their relative paths.
   - The resulting text is copied directly to your clipboard. Simply paste it into your desired application (e.g., an LLM interface).

## Customization

- **File Listing:**  
  The script uses `find . -type f` to list all files recursively. You can modify this command to restrict the search to specific file types or directories if needed.

- **Header Format:**  
  The header for each file is generated using:

  ```bash
  relative_path="${file#./}"
  echo "==> $relative_path <=="
  ```

  You can adjust this format by editing the echo statement in the script.

- **Alternate Key Bindings:**  
  If the spacebar binding does not suit your environment, you can change it by modifying the `--bind` option in the fzf command (e.g., using Tab instead).

## Troubleshooting

- **Spacebar Binding Issues:**

  - Make sure you have an up-to-date version of fzf.
  - If the spacebar still does not work, try changing the key binding (e.g., `--bind "tab:toggle"`).

- **Clipboard Utility Not Found:**  
  Ensure the appropriate clipboard tool is installed and available in your system's PATH.

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.
