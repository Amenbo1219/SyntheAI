# SyntheAI：PyTorch & TensorFlow Unified Development Environment（旧：Lyon-env）　version:2.1.a
TensorflowとPyTorchを誰でも簡単に利用できるように開発された，Nootebook形式のAI開発・研究環境です．

# 名称変更のお知らせ
利用者の拡大・外部サービスでの利用拡大の背景から名前をLyonに限定せず，利用できるように新たにSyntheAI(略称SAI)に変更しました．
色々な所属の方に使っていただき開発者として非常に誇らしいです！

# Requirement

* GPUサーバー環境（SSH接続でのログインを想定）
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
docker-compose build --no-cahce
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

# 類似するレポジトリ

本プロジェクトと類似した機能を持つDocker/Jupyter環境のリポジトリを紹介します。

* [Jupyter Docker Stacks](https://github.com/jupyter/docker-stacks)
    * Jupyter公式のDockerイメージ集。科学計算、機械学習、データサイエンス向けの様々なスタックを提供しています。

* [Coder](https://github.com/coder/coder)
    * クラウドベースの開発環境プラットフォーム。複数のユーザーで共有可能なワークスペースを提供します。

* [ML Workspace](https://github.com/ml-tooling/ml-workspace)
    * オールインワンのWebベース機械学習開発環境。Jupyter、VS Code、TensorBoard等を統合しています。

* [fastai/docker-containers](https://github.com/fastai/docker-containers)
    * fast.aiライブラリに最適化されたDockerコンテナ環境です。

* [NVIDIA NGC Containers](https://catalog.ngc.nvidia.com/containers)
    * NVIDIA公式のGPU最適化済みコンテナ。TensorFlow、PyTorch、RAPIDSなどが用意されています。

* [Deep Learning Container Images](https://github.com/aws/deep-learning-containers)
    * AWS提供のディープラーニング向けDockerイメージ集です。

# License
本リポジトリは、MITライセンスに基づいて提供されますが、以下の**追加利用規約**が適用されます。  
This repository is licensed under the MIT License, with the following **additional terms**.




## 追加条項 / Additional Terms

- 再配布の制限 / Redistribution Restriction: 作成者の事前許諾なしに、本リポジトリに含まれる「Environment（Docker構成・依存関係の設定等）」の再配布・公開（二次利用を含む）を禁止します。

Redistribution or publication of the Environment (modified or unmodified) is prohibited without prior written permission from the author.

- 構成の整合性 / Configuration Integrity: 本環境は特定のライブラリ構成で動作を検証したものです。構成の変更（バージョンの変更等）を伴う利用について、作者は一切の動作保証およびサポートを行いません。

要請への遵守 / Compliance with Requests: 作成者の許諾を得ている場合でも、公開停止や使用中止の要請があった際は速やかに従ってください。

Even with permission, you must promptly comply if the author requests the cessation of redistribution or use.

- 効力発生日 / Effective Date: 本追加条項は 2025年7月30日 より効力を発し、それ以前の再配布については適用されません（遡及適用なし）。

These terms take effect from July 30, 2025, and do not apply retroactively to activities before this date.

# 謝辞 / Acknowledgements
本リポジトリの開発にあたり、以下のリソースを参考にさせていただきました。

* **[TensorFlow Tutorials - 畳み込みニューラルネットワーク (CNN)](https://www.tensorflow.org/tutorials/images/cnn?hl=ja)** （動作検証用のベースコードとして活用させていただいております）
  
* **[PyTorch Tutorials - Neural Networks](https://docs.pytorch.org/tutorials/beginner/blitz/neural_networks_tutorial.html)** （PyTorch環境の動作確認用サンプルとして引用しております）
  
* **[CycleGAN (Unpaired Image-to-Image Translation)](https://github.com/junyanz/CycleGAN)** （本リポジトリでは、上記アルゴリズムを基に、佐々木氏 (sasakirh@stf.teu.ac.jp) が実装したものを用いております）
  
* **[Facades Dataset](https://www.kaggle.com/datasets/balraj98/facades-dataset)** （本リポジトリでは、上記データセットをMatファイル形式に変換し、学習・検証用データとして使用しております）
  （動作検証用のベースコードとして活用させていただいております。）

公式ドキュメントおよび関連書籍: Docker Hub 公式イメージおよび各ライブラリ（PyTorch/TensorFlow）のリファレンスを基に、依存関係の解決を行いました。
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
* README.mdを更新しました．
## 2025-07-29　Version2.0.b-release
* レポジトリの変更
* README.mdを更新しました．

## 2025-07-30　Version2.1.a-release
* [重要]本レポジトリの権利を保証するためLICENSEを設けました．詳細はLICENSEを御覧ください．
* ディープラーニング学習中に利用者が途中でブラウザを閉じてもプログラムが終了しないように設定を変更しました．
* README.mdを更新しました．

## 2026-02-06　LICENSE-release
* [重要]制限の適用範囲を明確にするため条項を改訂しました.以前のバージョンではサードパーティのコードに対しても制限が適用されると解釈されかねない記述が含まれていましたが, 今回の修正により, 独自構成（Environment）と第三者のコードを明確に分離しました. これは法的透明性の確保と権利関係の適正化を目的としています. 

* README.mdを更新しました．

# Author

作成情報を列挙する

* 作成者：Amembo1219
* E-mail： butabasuko@gmail.com
