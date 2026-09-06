# MS. PICO-MAN / checklist

## o que está feito?
- [x] draw do mapa, dots e sprites pacman+ghosts
- [x] movimento do pacman
- [x] movimento dos fantasmas
- [x] cálculo target pacman cada fantasma
- [x] parte da collision (tem 'is solid' para os fantasmas colidirem com a parede)
- [x] movimento linear ininterrupto pacman
- [x] colisão pacman nas paredes
- [x] transportar pelas laterais


## o que falta?

- [ ] comer dots *(pequeno->10pts e grande->50pts+frightened mode)*
- [ ] fruta *(aparece 2x na partida, embaixo da casa dos fantasmas, primeiro depois de comer 70 dots e de novo, 170 dots; desaparece depois de 9-10 segs)*
- [ ] colisão pacman e fantasmas
- [ ] morte pacman
- [ ] ghosts states (normal=chase, scatter, frightened=random, eaten/dead=eyes)
	- [ ] frightened mode fantasmas *(depois do pellet grande)*
	- [ ] poder comer os fantasmas frightened
- [ ] vidas *(são 3)*
- [ ] score e high score
- [ ] velocidade fracionada
- [ ] progressão de dificuldade/velocidade


### extra:
- pequeno problema com a porta de saída dos fantasmas, seria para pensar como resolver depois


## gráfico:

- [ ] desenhar frutas
- [x] desenho dos fantasmas scatter
- [ ] sprite só olhinhos qnd fantasmas morrem (testar com transparência)
- [ ] animação dos sprites 
	- [x] pacman andando
	- [x] fantasmas andando (loop pernas)
	- [x] fantasmas olhando pros lados
	- [x] pacman morrendo (quando o pacman morre ele abre todinho e poof, some com umas linhas em círculo)

no layout tem:
high score (meio topo) ;
3 vidas (inf esq) ;
fruta (inf dir)

// no nosso caso todos podem estar no lado, na vertical //