default:
	@echo "Usage:"
	@echo "  make run...........compile and run Caml-flage"
	@echo "  make compile.......compile Caml-flage"
	@echo "  make clean.........remove build files"
	@echo "  make save..........save current state in JSON"

test:
	@ocamlbuild -pkgs 'ezjsonm,ounit' test.byte && ./test.byte

run:
	@sleep 5 && open "http://localhost:3000" && echo "" && echo "Press ctrl-c to quit!" &
	@ocamlbuild -pkg opium server.native && echo "Your browser will open in a moment..." && ./server.native 

server:
	@ocamlbuild -pkg opium server.native

compile:
	@ocamlbuild -pkg opium server.native

clean:
	@ocamlbuild -cleana

save:
	@curl "http://localhost:3000/savethestate" && echo "" && echo "Saved the state"
