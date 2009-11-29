
.PHONY: clean tag release

VERSION=2

clean:
	rm -f *~

tag: clean
	cvs tag NoRandomOculus-$(VERSION)

release: clean
	( cd ..;							\
		rm -f NoRandomOculus-$(VERSION).zip;			\
		find NoRandomOculus					\
				-name CVS -prune -o			\
				-name .svn -prune -o			\
				-name Makefile -prune -o		\
				-name '.*.swp' -prune -o		\
				-print					\
		| zip -@ NoRandomOculus-$(VERSION).zip;			\
	)	
