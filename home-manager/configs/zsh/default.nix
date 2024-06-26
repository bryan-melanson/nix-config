{ ... }:
{
	programs.zsh = {
		enable = true;
		enableCompletion = true;
		enableAutosuggestions = true;
		oh-my-zsh = {
			enable = true;
			plugins = [ "git" ];
			theme = "af-magic";
		};
		sessionVariables = rec {
			EDITOR = "nvim";
		};
	};
}
