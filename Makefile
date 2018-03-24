default:
	@echo "Usage:"
	@echo "  make server                    build and run server"
	@echo "  make clean                     remove build files"

server:
	ocamlbuild -pkg opium server.native && ./server.native

compile:
	ocamlbuild -pkg opium server.native

clean:
	ocamlbuild -clean