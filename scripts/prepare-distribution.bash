#!/dev/null

if ! test "${#}" -eq 0 ; then
	echo "[ee] invalid arguments; aborting!" >&2
	exit 1
fi

"${_git_bin}" submodule update --quiet --init --recursive
"${_git_bin}" submodule foreach --quiet --recursive 'chmod -R +w . && git reset -q --hard HEAD && git clean -q -f -d -x'

case "${_distribution_local_os}" in
	( mos )
		tazpkg get-install git
		tazpkg get-install mosaic-sun-jdk-7u1
		tazpkg get-install mosaic-nodejs-0.6.15
		tazpkg get-install mosaic-erlang-r15b01
	;;
	( unknown )
	;;
	( * )
		echo "[ee] invalid local OS \`${_distribution_local_os}\`; aborting!" >&2
		exit 1
	;;
esac

if test ! -e "${_repositories}/mosaic-java-platform/.lib" ; then
	ln -s -T -- "${_tools}/lib" "${_repositories}/mosaic-java-platform/.lib"
fi

exit 0