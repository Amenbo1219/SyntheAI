# SyntheAI： PyTorch, TensorFlow and JAX Unified Development Environment version:3.1
TensorflowとPyTorchを誰でも簡単に利用できるように開発された，Notebook形式のAI開発・研究環境です．元来東京工科大学Lyon環境での利用を想定していましたが, Lyon以外での環境にも利用可能に変更いたしました. 
## 依存関係の更新履歴
[最新のライブラリ更新レポートはこちら (LIBRARY_UPDATE.md)](LIBRARY_UPDATE.md)
# Version:3.0-Release🎉🎉
SynthAIがメジャーバージョンアップしました!!
* JAXの需要に答えるため、JAX環境も利用できるようになりました。デモコードは近日配布します。
* ライブラリの自動更新機能をリリースしました！自動で依存関係を調査し、必要であれば更新します。
* UVに対応しライブラリのビルド時間が短縮されました
* 自動化に伴い内部のコードを調整しました。


# 謝辞 / Acknowledgements
本リポジトリの開発にあたり、以下のリソースを参考にさせていただきました。
* Lyonに関する教育用コンテンツ |東京工科大学 大野先生
* [DockerでGPUが使えるJupyter環境を作る|はてなブログ: まくんごろん氏](https://makungoron-music.hatenablog.com/entry/docker-jupyter)
* [DockerでGPUを利用するための環境構築|IDnet 技術コラム](https://www.idnet.co.jp/column/page_187.html)

上記のリソースはいずれも、Docker上でGPUリソースを適切に割り当て、Jupyter環境を構築する手法として優れた知見を含んでおります。
本リポジトリの制作にあたっては、大野先生のLyonに関する教育用コンテンツより多大な影響と着想をいただいております。これに加え、Web上で公開されている各技術資料からも多くの知見を拝借し、それらを自身の研究環境に合わせて整理・統合することで、本パッケージを形にすることができました。
貴重な知見を惜しみなく公開されている各氏に、心より感謝申し上げます。

* **[TensorFlow Tutorials - 畳み込みニューラルネットワーク (CNN)](https://www.tensorflow.org/tutorials/images/cnn?hl=ja)** （動作検証用のベースコードとして活用させていただいております）
  
* **[PyTorch Tutorials - Neural Networks](https://docs.pytorch.org/tutorials/beginner/blitz/neural_networks_tutorial.html)** （PyTorch環境の動作確認用サンプルとして引用しております）
  
* **[CycleGAN (Unpaired Image-to-Image Translation)](https://github.com/junyanz/CycleGAN)** （本リポジトリでは、上記アルゴリズムを基に、東京工科大学 佐々木氏 (sasakirh@stf.teu.ac.jp) が実装したものを用いております）
  
* **[Facades Dataset](https://www.kaggle.com/datasets/balraj98/facades-dataset)** （本リポジトリでは、上記データセットをMatファイル形式に変換し、学習・検証用データとして使用しております）
  （動作検証用のベースコードとして活用させていただいております。）

公式ドキュメントおよび関連書籍: Docker Hub公式イメージおよび各ライブラリ（PyTorch/TensorFlow）のリファレンスを基に、依存関係の解決を行いました。

# Requirement

* GPUサーバー環境（SSH接続でのログインを想定）
* CUDA11.8以降での動作を想定しています
* Dockerシステムの環境構築済みであること(nvidia-Dockerの環境構築が済んでいること)
* DockerCompose環境
* vGPU利用化での利用を想定(通常環境の方はNoteを参照してください．)


# Installation

GitHubからシステムを取得する
```bash
git clone https://github.com/Amenbo1219/SyntheAI.git
```
SyntheAIのディレクトリに移動する
```bash
cd SyntheAI
```
Docker-compose をビルドする
```bash
docker-compose build --no-cache
```
ビルドしたイメージを起動する
```bash
docker-compose up -d
```
ブラウザから http://ホスト名:8888 にログインする

# Note

* ビルドを早くしたい
    起動の際にライブラリの数を減らしたliteブランチとpytorchのブランチを作成しました．
* Pythonの他ライブラリを追加したい

     [py3/requirements.txt](py3/requirements.txt)に追加したいモジュールを追加する。
* イメージを変更・修正したい

     [py3/Dockerfile](py3/Dockerfile)に追加したいモジュールを追加する。

* ポート番号の変更・GPUメモリの割当量・GPUのID指定を変更したい

     [docker-compose.yml](docker-compose.yml)を変更する。

* vGPUを用いていない環境(通常の環境)で利用したい

     [docker-compose.yml](docker-compose.yml)の#GPUを使う場合の設定以下4行(environment)をコメントアウトしてください
* JupyterのTokenを確認したい

     イメージビルド中にLogを確認し、LogからTokenを探す
    ```bash
    docker compose logs
    ```
* Jupyterにパスワードを設定したい

    　　コンテナが起動しているものとする。

    ```bash
    docker compose up -d
    ```
    コンテナにパスワードを設定する
    ```bash
    $ docker-compose exec py3 bash
    --- 以下、コンテナの中
    # jupyter notebook password
    # exit
    --- コンテナを再起動
    $ docker-compose down
    $ docker-compose up -d
    ```
* 外部のサイトからファイルを取得したい
  
  事前学習モデルやデータセットなど外部のサイトからファイルを取得する場合は，一番最初のセルでパッケージの更新を行うことで取得できるようになります．
  ```bash
  !apt update -y
  ```
    
* おすすめのイメージは？

    この辺のイメージがおすすめです

    * [Tensorflow系を使う場合|DockerHub](https://hub.docker.com/r/tensorflow/tensorflow/tags)

    * [Pytorch系を使う場合|DockerHub](https://hub.docker.com/r/pytorch/pytorch/tags)

    * [Cudaを使う場合|DockerHub](https://hub.docker.com/r/nvidia/cuda/tags)

* Tensorflowのイメージには何が含まれていますか？

     [テスト済みのビルド構成|Tensorflow](https://www.tensorflow.org/install/source?hl=ja#gpu)


# LICENSE
本リポジトリは MIT License のもとで公開されています。 This repository is licensed under the MIT License.

* 概要 / Summary
ソフトウェア（コード） / Software: MITライセンスに基づき、自由に使用・改変・配布が可能です。

* 環境設定 / Environment (Docker, dependencies): 構成の改変や再配布は自由ですが、作成者はその動作を保証しません。

* サポート / Support: 構成の変更を伴う「派生物」への個別サポートは一切行いません。
# 修正・改善の提案について / Pull Requests
本リポジトリの構成やライブラリの依存関係に関する修正、あるいは機能改善の提案がある場合は、**プルリクエスト（Pull Request**をお送りください。

具体的な修正内容と意図が示されているPRについては、内容を確認し、適宜対応を検討いたします。

PRを伴わない個別の動作不良に関するご相談や、環境構築のサポート依頼については、対応いたしかねますのであらかじめご了承ください。

# ReleaseNote
## 2023-05-22　Version1.0-release
* ファストコミット。
## 2023-05-22　Version1.0a-release
* デフォルトの共用メモリの容量を変更しました
## 2023-05-22　Version1.0b-release
* README.mdを更新しました。
 環境構築手法・参考文献・作成者情報を添付しました。
## 2023-06-24　Version1.1-release
* Compose上の共用メモリの記載に一部誤りがありましたので修正しました。
* DEMOスクリプトにCycleＧanのスクリプトを追加しました。
## 2023-06-24　Version1.1a-release
* README.mdを更新しました。
* Version情報を追記しました。
## 2023-11-03　Version1.1b-release
* README.mdを更新しました。
* GPUIDの指定を行いました．
## 2024-01-13　Version1.1c-release
* lite(軽量版)とtorch(Pytorch版)のブランチを作成しました。
* README.mdを更新しました。
## 2024-06-09　Version1.1d-release
* Pytorchのバージョンを固定にしました．
* README.mdを更新しました。
* Author情報を更新しました．
## 2024-06-26　Version1.1e-release
* restart設定を変更しました．
* README.mdを更新しました．
## 2024-10-05　Version2.0-release
* ライブラリのバージョンを一式更新しました．
* README.mdを更新しました．
## 2024-10-05　Version2.0.a-release
* Dockerfileの一部を修正しました
* リポジトリ名を変更しました
* README.mdを更新しました．
## 2025-07-30　LICENSE-release
* [重要]本レポジトリの権利を保証するためLICENSEを設けました．詳細はLICENSEを御覧ください．
* ディープラーニング学習中に利用者が途中でブラウザを閉じてもプログラムが終了しないように設定を変更しました．
* README.mdを更新しました．
## 2026-02-10　LICENSE-Update・DockerfileCleanUp
* ライセンスの緩和と運用方針の変更
  
権利不備に関するご指摘を真摯に受け止め、ライセンス定義を MIT基準 へと緩和・再定義いたしました。
動作要件の確認や環境改善のご要望については、プルリクエスト（PR） を通じたオープンな開発体制へと移行いたしました。
* Dockerfile & README メンテナンス
  
Dockerfileの構成を一部最適化し、コメントを最新の情報へ修正しました。
README.mdに「謝辞（Acknowledgements）」を追記しました。
* お詫び
  
本件において、不適切なライセンス設定や表記によりご不安・ご迷惑をおかけした皆様に、深くお詫び申し上げます。今後は透明性の高い開発・管理に努めてまいります。
## 2026-02-15　Version2.0.0-final-release
* CUDA関係のバージョンの整理をしました
## 2026-02-20　Version3.0-release
* ライブラリを自動で更新する機能を導入しました。クオーターごとに自動更新が走るようになります。
* GoogleのAI用開発ライブラリ**JAX**が利用できるようになりました。
* Diffusion等のCV系のタスクが扱えるパッケージを追加しました
## 2026-02-26　Version3.1-release
* [uv](https://github.com/astral-sh/uv)を用いた高速ビルドを導入しました。(ライブラリのインストール時間が大幅に削減されています)
* JupyterLAB内のターミナルをbashに変更し、自動補完機能も導入しました。


  
# Author

作成情報を列挙する

* 作成者：Amembo1219
* E-mail： butabasuko@gmail.com

