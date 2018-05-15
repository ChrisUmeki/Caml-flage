1. opam install opium ezjsonm - installs external dependencies
2. npm start - runs bucklescript, which compiles re to bs.js
3. npm run webpack - runs webpack, which takes those bs.js files, as well as their dependencies in node_modules, and condenses them all together into Index.js
4. make run - compiles server, runs it, and opens browser to homepage. 

