{ lib, ... } :
{
	programs.kitty = {
		enable = true;
		font.name = "JetBrainsMono Nerd Font";
		theme = "Space Gray Eighties";
		settings = {
			scrollback_lines = 10000;
			enable_audio_bell = false;
		};
	};
}
