# gm82vpatch
This extension will improve frame pacing in GM8 games, by exploiting a DX8 swapchain delay.

## Deprecation notice
This extension has had a lot of research put into it, but ultimately the solution was poking DirectX8 directly. As such, we've moved our findings to the [GM 8.2 DirectX8 Extension](https://github.com/omicronrex/gm82dx8), where it can be fully realized. This repo will continue existing, but won't receive updates. Please use the new extension instead.

## How it works
We're not exactly sure of why and how, but we have tested and confirmed that it does work.

Our leading theory is that DX8 grabs the new frame a few milliseconds after a DDraw vsync. By sleeping a few milliseconds, we delay our next frame beyond that frame boundary, preventing DX8 from grabbing a new frame too early and skipping a frame. By manually vsyncing at the end of the event loop rather than at the start, we avoid adding an extra frame of lag.

## Usage
1. Install the extension and add it to your project.
2. Turn off Vsync in the game options, and remove any calls to screen_wait_vsync() from the game.
3. If possible, add the 8.2 Core extension for more precise operation.
