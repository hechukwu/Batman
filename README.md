# Batman

An application that presents a list of all the movies ever created about Batman, the Marvel superhero. This is an assessment project to build a native iOS app for Carbon.


### API Used
The OMDB API was used
- A list of Batman movies: GET https://www.omdbapi.com/?s=Batman&apikey=\(OMDB_API_KEY)


### Development
This application was developed using [Swift](https://swift.org/), Core data to persist users favourite movies, MVVM for design pattern, and storyboard for UI.

### Sorting

One thing that happens when multiple people work on an Xcode project is crazy merge conflicts. Anytime a file is added or removed to/from a project, Xcode sorts the project file (somewhat randomly). This creates all sorts of problems with source control and results in many headaches.

The solution is to sort the file alphabetically prior to any commit.

I accomplish this using a git pre-commit hook that calls `xUnique`.

### xUnique

[xUnique](https://github.com/truebit/xUnique) is a python module.

It can be installed by running: `pip install xUnique`

It also installs a command line script `xunique` in directory `/usr/local/bin` (make sure you have added this directory to your `$PATH`), so that xUnique can be invoked directly from the command line.

### pre-commit hook

Here is an example pre-commit hook.

You can use it as a basis for modifying your `.git/hooks/pre-commit` hook file.

```
#!/bin/sh
/path/to/Dynamic-Form/Scripts/uniquify_projects.sh
```

Make sure that it has an executable bit (`chmod +x .git/hooks/pre-commit`) and that the path is correct.
