# Trackt-Involves TV Series
Este é um aplicativo para iOS voltado para teste de desenvolvedor na Involves, implementado conforme solicitado via [Documento]( https://github.com/involvestecnologia/selecaoinvolves/blob/master/teste-iOS-2017-01.md).

## O projeto:
O projeto abrange todos os requisitos solicitados para considerar-se um aplicativo **decente**, sendo eles:
* Uma lista das séries que o usuário está assistindo no momento;
* A informação de quantos por cento da série já foi concluída;
* Qual o próximo episódio e sua respectiva data;
* Uma página com as informações dos episódios;
* Marcar como assistido um episódio.

Além dos requisitos essenciais, foram implementados também:
* Possibilidade de buscar séries;
* Adicionar uma série na watchlist;
* Armazenamento local de séries sendo assistidas e da watchlist, e seus respectivos episódios.

### Como executar o projeto:
* Após clonar o repositório para sua máquina local, certifique-se que tenha [CocoaPods](https://cocoapods.org) instalado;
* Com o *CocoaPods* instalado, abra o terminal e vá até a pasta onde se encontra o arquivo **Podfile**, e execute o comando: 
```
pod install
```
* Abra o arquivo **trakt-involves.xcworkspace**, utilizando a IDE *Xcode*;
* Com o *Xcode* aberto, pressione os botões **Command + R** para executar o projeto.

### Como executar testes:
* No *Xcode*, abra a aba *Test navigator* e execute os testes **trakt-involvesTests**.
*Foram implementados testes somente para uma tela, como forma de comprovação de ciência na implantação do assunto, e também devido ao curto tempo para sua implementação*
