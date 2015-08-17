TARGET= 	/net/smb/pbui@fs.nd.edu/www
COMMON= 	$(shell ls static/yaml/*.yaml) 	\
		  scripts/yasb.py 			\
		  templates/base.tmpl
RSYNC_FLAGS= 	-rv --size-only --copy-links --progress --exclude="cs.*.*" --exclude="idis.*.*" --exclude="*.swp" --exclude="*.yaml"
YAML=		$(shell ls pages/*.yaml pages/*/*.yaml)
HTML= 		${YAML:.yaml=.html}

%.html:		%.yaml ${COMMON}
	./scripts/yasb.py $< > $@

all:		${HTML}

install:	all
	mkdir -p ${TARGET}/static
	rsync ${RSYNC_FLAGS} pages/.		${TARGET}/.
	rsync ${RSYNC_FLAGS} static/.      	${TARGET}/static/.

clean:
	rm -f ${HTML}
