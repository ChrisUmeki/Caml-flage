default:
	@echo "Usage:"
	@echo "  make run...........compile and run Caml-flage"
	@echo "  make compile.......compile Caml-flage"
	@echo "  make clean.........remove build files"

run:
	sleep 2 && open "http://localhost:3000" & ocamlbuild -pkg opium server.native && ./server.native;

server:
	ocamlbuild -pkg opium server.native

compile:
	ocamlbuild -pkg opium server.native

clean:
	ocamlbuild -clean
