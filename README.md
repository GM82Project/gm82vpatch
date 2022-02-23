# gm82vpatch
This extension will improve frame pacing in GM8 games, by exploiting a DX8 swapchain delay.

## Deprecation notice
This extension has had a lot of research put into it, but ultimately the solution required poking DirectX8 directly. As such, we've moved our findings to the [GM 8.2 DirectX8 Extension](https://github.com/omicronrex/gm82dx8), where it can be fully realized, and as a pack-in for [Debugger Helper](https://delicious-fruit.com/ratings/game_details.php?id=23936). This repo will continue existing, but won't receive further updates.

## How it works
When the game presents, DX8 copies the new frame a few milliseconds after a DDraw vsync event. By sleeping a few milliseconds, we delay our next frame beyond that frame boundary, preventing DX8 from grabbing a new frame too early and grabbing the old frame. Additionally, by manually vsyncing at the end of the event loop rather than at the start, we avoid adding an extra frame of lag to the game feel.
