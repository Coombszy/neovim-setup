# Neovim config

## Installation (Ubuntu)
1. Install custom font in `fonts` folder (And set terminal to use it)
2. Install packages:
```sh
sudo apt update
sudo apt install fzf ripgrep fd-find
```
3. Install node >= 18
4. Run 
```sh
./clean-install.sh
```

### For vim version/profile swapping
Add the following to `.bashrc`, (Requires fzf to be installed)
```.bashrc
# Setup nvim config switcher
if command -v fzf --help &> /dev/null && command -v nvim --version &> /dev/null
then
	alias nvim-java="NVIM_APPNAME=nvim-java nvim"
	alias nvim-old="NVIM_APPNAME=nvim-old nvim"
	
	function nvims() {
	  items=("default" "java" "old")
	  config="nvim-$(printf "%s\n" "${items[@]}" | fzf --prompt=" Neovim Config" --height=50% --layout=reverse --border --exit-0)"
	  if [[ -z $config ]]; then
	    echo "Nothing selected"
	    return 0
	  elif [[ $config == "default" ]]; then
	    config=""
	  fi
	  NVIM_APPNAME=$config nvim $@
	}
fi
```

## Installation (Windows)
1. TODO?

