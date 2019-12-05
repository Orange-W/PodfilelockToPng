# ProfilelockToPng
Reference relationship visualization.Transform Cocoapods's Pprofile.lock to png.

![image](https://github.com/Orange-W/ProfilelockToPng/blob/master/output.dot.png)

### Dependency
To install dependency `graphviz`.
[go now](https://graphviz.gitlab.io/download/)

### How to use

Just run script.

```
sh ./printlock.sh
```

Or aim path file , output.file

```
sh ./printlock.sh ./Profile.lock output.dot
```

### What's more?
You can hide te subspect Dependency.
![image](https://github.com/Orange-W/ProfilelockToPng/blob/master/disableSubspec.dot.png)

```
sh ./printlock.sh ./Profile.lock output.dot 1
```
