# [Slurp]: Flexible File Content Slurper

This tool is a Bash script that helps you quickly gather content from multiple files and copy it to your clipboard. It offers two main modes of operation:

1.  **Interactive Mode:** Uses [fzf](https://github.com/junegunn/fzf) to interactively select files from the current directory and its subdirectories.
2.  **Argument Mode:** Allows you to specify files and directories directly as command-line arguments, similar to the `cp` command, including support for shell globs (e.g., `*`) and recursive processing of directories.

In both modes, the content of the selected/specified files is concatenated—each preceded by a header showing its path—and the resulting text is copied to your clipboard. This is especially useful for quickly preparing content to paste into an LLM, documentation, or any other application.

## Features

- **Dual Operation Modes:**
  - **Interactive File Selection:** Uses [fzf](https://github.com/junegunn/fzf) in multi-select mode (`space` to toggle, `Enter` to confirm).
  - **Command-Line Arguments:** Specify files, directories, or use shell globs (like `*.txt`) directly on the command line.
- **Recursive Directory Processing:**
  - Use the `-r` or `-R` option with directories in argument mode to include content from all files within them recursively.
- **Concatenated Output with Headers:**
  - Each file’s content is preceded by a header displaying its relative path, making it clear which file each section belongs to.
- **Clipboard Integration:**
  - Automatically copies the final output to your clipboard using `pbcopy` (macOS), `xclip` or `wl-copy` (Linux). If no clipboard utility is found, the output is saved to a temporary file, and its path is displayed.
- **Cross-Platform Compatibility:**
  - Designed to work on macOS and Linux.

## Requirements

- **bash:** The script is written in Bash.
- **fzf:** For interactive file selection mode.
  - Installation instructions can be found on the [fzf GitHub page](https://github.com/junegunn/fzf#installation). (Not required if you only use argument mode).
- **Clipboard Utility:**
  - **macOS:** `pbcopy` (usually pre-installed).
  - **Linux:** Either [`xclip`](<https://www.google.com/search?q=%5Bhttps://github.com/astrand/xclip%5D(https://github.com/astrand/xclip)>) or [`wl-copy`](<https://www.google.com/search?q=%5Bhttps://github.com/bugaevc/wl-clipboard%5D(https://github.com/bugaevc/wl-clipboard)>).
    - Install via your package manager, for example:
      ```bash
      sudo apt-get install xclip
      # or
      sudo apt-get install wl-clipboard
      ```
- **Optional (for enhanced fzf experience):**
  - [`bat`](<https://www.google.com/search?q=%5Bhttps://github.com/sharkdp/bat%5D(https://github.com/sharkdp/bat)>) for syntax-highlighted file previews in `fzf`. `fzf` can automatically use `bat` if it's installed and `FZF_PREVIEW_COMMAND` is set or via its configuration.

## Installation

1.  **Save the Script:**
    Save the script code to a file, for example, `your_script_name.sh`.

2.  **Ensure Dependencies Are Installed:**
    Verify that `bash` and your chosen clipboard utility (`pbcopy`, `xclip`, or `wl-copy`) are installed. If you plan to use the interactive mode, ensure `fzf` is also installed.

3.  **Make the Script Executable:**

    ```bash
    chmod +x your_script_name.sh
    ```

4.  **Place it in your PATH (Optional):**
    For easier access, you can move `your_script_name.sh` to a directory in your system's `PATH` (e.g., `/usr/local/bin/` or `~/.local/bin/`).

## Usage

The script can be run in several ways:

### 1\. Interactive Mode (with fzf)

If you run the script without any file/directory arguments, it will launch `fzf` for interactive selection:

```bash
./your_script_name.sh
```

Or, if you include `-r` without path arguments, it will also enter `fzf` mode:

```bash
./your_script_name.sh -r
```

- Use the arrow keys to navigate the file list.
- Press the **spacebar** to toggle selection for a file.
- Once you've selected all desired files, press **Enter**.

### 2\. Argument Mode (cp-like)

You can provide file paths, directory paths, or shell-expanded globs as arguments:

- **Specific files:**

  ```bash
  ./your_script_name.sh file1.txt path/to/file2.md
  ```

- **Using shell globs (e.g., all `.js` files in `src/`):**

  ```bash
  ./your_script_name.sh src/*.js
  ```

- **All non-hidden items in the current directory (shell expands `*`):**

  ```bash
  ./your_script_name.sh *
  ```

  (If `*` expands to include directories, their contents will be skipped unless `-r` is used; a warning will be shown for the directory itself.)

### 3\. Recursive Processing in Argument Mode

Use the `-r` or `-R` option to process directories recursively. This option applies when directories are provided as arguments.

- **Recursively process files in `my_project_dir/`:**

  ```bash
  ./your_script_name.sh -r my_project_dir/
  ```

- **Process `file.txt` and all files recursively within `another_dir/`:**

  ```bash
  ./your_script_name.sh -r file.txt another_dir/
  ```

  (Note: `-r` primarily affects how directory arguments are handled. It doesn't change how individual file arguments are processed.)

### Pasting the Output

After the script runs successfully, the concatenated content (with headers) from the selected/specified files is copied directly to your clipboard. Simply paste it into your desired application.
If no clipboard utility is found, the script will print the path to a temporary file containing the output.

## Customization

- **File Listing in fzf Mode:**
  - The `fzf` mode uses `find . -type f` to list all files recursively from the current directory. You can modify this `find` command within the script to restrict the search (e.g., `find . -name "*.txt" -type f` for only text files).
- **Header Format:**
  - The header for each file is generated by:
    `bash
relative_path="${file#./}"
echo "==> $relative_path <=="
`
    You can adjust this `echo` statement in the script to change the header.
- **fzf Key Bindings:**
  - The `fzf` command uses `--bind "space:toggle"`. You can change this binding (e.g., to `tab:toggle`) by modifying the `--bind` option in the script.

## Troubleshooting

- **fzf Key Binding Issues (e.g., spacebar not working):**
  - Ensure you have an up-to-date version of `fzf`.
  - Try changing the key binding in the script (e.g., `--bind "tab:toggle"`).
- **Clipboard Utility Not Found:**
  - Ensure the appropriate clipboard tool (`pbcopy`, `xclip`, `wl-copy`) is installed and available in your system's `PATH`. The script will notify you if it cannot find one.
- **Arguments Not Working as Expected:**
  - Verify that file and directory paths are correct.
  - Remember that shell globs (like `*`) are expanded by your shell _before_ the script sees them. Use `echo *` to see how a glob expands in your current directory.
  - The script will print warnings for files or directories it cannot find or process.

## License

This project is licensed under the MIT License. (If you have a LICENSE file, ensure it's present and named correctly, e.g., `LICENSE` or `LICENSE.md`).

---
