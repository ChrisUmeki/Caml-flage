default:
	@echo "Usage:"
	@echo "  make run...........compile and run Caml-flage"
	@echo "  make compile.......compile Caml-flage"
	@echo "  make clean.........remove build files"

run:
	@sleep 3 && open "http://localhost:3000" && echo "" && echo "Press ctrl-c to quit!" &
	@ocamlbuild -pkg opium server.native && ./server.native

server:
	@ocamlbuild -pkg opium server.native

compile:
	@ocamlbuild -pkg opium server.native

clean:
	@ocamlbuild -clean
