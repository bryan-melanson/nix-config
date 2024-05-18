{ config, pkgs, ... }:
{
	programs.neovim = {
		vimAlias = true;
		plugins = with pkgs.vimPlugins; [
			auto-pairs
			fzf-vim
			lightline-vim
		];
	};
}
