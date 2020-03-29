FROM archlinux

RUN yes | pacman -Sy opam make m4 gcc patch diffutils ffmpeg git automake autoconf pkg-config which 

RUN useradd liq && mkdir /home/liq && chown -R liq /home/liq

ENV HOME=/home/liq

USER liq

RUN opam init --disable-sandboxing --yes

WORKDIR /home/liq

RUN for i in ocaml-ffmpeg ocaml-dtools ocaml-duppy ocaml-mm ocaml-cry liquidsoap; do \
      cd /home/liq && git clone https://github.com/savonet/$i && cd $i && opam pin add --yes --no-action .; \
    done 

RUN opam install --yes liquidsoap ffmpeg cry
