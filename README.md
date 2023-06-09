# PodfilelockToPng
Reference relationship visualization.Transform Cocoapods's Podfile.lock to png.

![image](https://github.com/Orange-W/PodfilelockToPng/blob/master/output.dot.png)

### Dependency
To install dependency `graphviz`.
```
brew install graphviz
```

### How to use

Just run script.

```
sh ./printlock.sh
```

To aim the path file and output.file

```
sh ./printlock.sh -i ./Podfile.lock -o output.dot
```

### What's more?
You can hide te subspect Dependency.
![image](https://github.com/Orange-W/PodfilelockToPng/blob/master/disableSubspec.dot.png)

```
sh ./printlock.sh -i ./Podfile.lock -o output.dot  -n
```

only show AFNetworking Dependency, use --only.( -n will invalid)
```
sh ./printlock.sh -i ./Podfile.lock -o output.dot  --only AFNetworking
```
