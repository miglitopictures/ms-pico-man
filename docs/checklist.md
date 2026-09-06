# MS. PICO-MAN / checklist

## o que está feito?
- [x] draw do mapa, dots e sprites pacman+ghosts
- [x] movimento do pacman
- [x] movimento dos fantasmas
- [x] cálculo target pacman cada fantasma
- [x] parte da collision (tem 'is solid' para os fantasmas colidirem com a parede)


## o que falta?

- [ ] comer dots *(pequeno->pontos e grande->scatter mode)*
- [ ] fruta *(aparece 2x na partida, embaixo da casa dos fantasmas, primeiro depois de comer 70 dots e de novo, 170 dots; desaparece depois de 9-10 segs)*
- [ ] movimento linear ininterrupto pacman
- [ ] colisão pacman nas paredes
- [ ] colisão pacman e fantasmas
- [ ] morte pacman
- [ ] scatter mode fantasmas *(depois do pellet grande)*
- [ ] poder comer os fantasmas scatter
- [ ] transportar pelas laterais
- [ ] vidas *(são 3)*
- [ ] score e high score


### extra:
- pequeno problema com a porta de saída dos fantasmas, seria para pensar como resolver depois


## gráfico:

- desenhar frutas
- desenho dos fantasmas scatter
- sprite só olhinhos qnd fantasmas morrem
- animação dos sprites 
	- pacman andando
	- fantasmas andando (loop pernas)
	- fantasmas olhando pros lados
	- pacman morrendo (quando o pacman morre ele abre todinho e poof, some com umas linhas em círculo)

no layout tem:
high score (meio topo) ;
3 vidas (inf esq) ;
fruta (inf dir)

// no nosso caso todos podem estar no lado, na vertical //