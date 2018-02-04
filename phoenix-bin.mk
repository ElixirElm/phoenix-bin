# Author: umur.ozkul@gmail.com
.PHONY: init deps release
init:
	mix ecto.create
	mix ecto.migrate
	mix run priv/repo/seeds.exs

deps:
	mix deps.get
	(cd assets && npm install --quiet)

compile: deps
	make e4ToJs #Compile e4 subprojects
	(cd assets && brunch build --production)
	MIX_ENV=prod mix phx.digest
	MIX_ENV=prod mix compile

