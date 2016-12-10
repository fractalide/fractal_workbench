# fractal_workbench
## Fractalide Workbench

![Image Alt](https://www.woodgears.ca/workshop/jacques/004.jpg)

This repository serves as your workbench, this is where you craft new things and try out interesting ideas. A new workspace for a new idea!
Whereas the [canonical](https://github.com/fractalide/fractalide) fractalide repo is your tool rack. The tool rack is where useful, successful ideas forged on your workbench go to live a new life, to be further used and refined by the community! Please consider [plugging](https://github.com/fractalide/fractalide/blob/master/nodes/example/wrangle/default.nix#L8-L15) your works into fractalide so that we all can benefit from it!

Typically we refer to this type of repository as a `fractal`. It's like a library or module in a programming language, but it's much more nuanced than that!

You're encouraged to use [Mozilla Public License v2](LICENSE) for your project. This makes it very easy for the community to mix and match nodes, and is key to our success as a community.
We also encourage you to use the [C4](CONTRIBUTING.md) to govern your project, having the same governance across projects means high quality patches will fly fast and efficiently. It would be really nice if everyone was tuned to the same note before we start this symphony!

If you want to make use of Incremental Builds (you really do) then you'll need to plug this project into a clone of Fractalide and build from within the Fractalide folder. See Fractalide's [README.md](https://github.com/fractalide/fractalide) for more details

---

### Project Description:

... <describe your project>
### Project Problem:

... <clear problem description, the cause for this project>
### Solution:

... <describe solution your project has taken>
### Stability:

Choose one:
[Experimental, Stable, Legacy, Deprecate]

### Build Instructions
Make sure you have installed [nix](https://nixos.org/nix) installed, most likely your package manage has `nix` available, if not you'll need to compile from source.
```
$ NIX_PATH="nixpkgs=https://github.com/NixOS/nixpkgs/archive/125ffff089b6bd360c82cf986d8cc9b17fc2e8ac.tar.gz:fractalide=https://github.com/fractalide/fractalide/archive/master.tar.gz"
$ git clone git@github.com:fractalide/fractal_workbench.git
$ cd fractal_workbench
$ nix-build
```
