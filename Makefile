.PHONY: serve venv

cli_crackme:
	cc -g -ICrackMe -o cli_crackme cli_crackme.c CrackMe/CrackMe/validate.c

serve:
	cd slides && python -m SimpleHTTPServer

venv:
	virtualenv -p python2.7 venv
