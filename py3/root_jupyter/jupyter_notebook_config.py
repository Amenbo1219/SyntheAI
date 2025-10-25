c = get_config()
c.MappingKernelManager.cull_idle_timeout = 0      # カーネルのアイドルタイムアウトを無効化
c.MappingKernelManager.cull_connected = False     # ブラウザ切断後も保持
