# 概要

シェルスクリプト実行中にスクリプトファイルを上書きすると
実行中のスクリプトを実行後に、上書きされたスクリプトが実行され
意図しない挙動が発生するケースがあるらしい。

https://www.iimc.kyoto-u.ac.jp/ja/whatsnew/information/detail/211228056999.html

現象の再現確認用にtest.shを作成しています。

# シェルスクリプトの読み込みについて

シェルスクリプトの実行はスクリプト全体を読み取って実行するわけではなく  
ブロック単位で読み込みが発生し、実行が終了後、ファイルの読み込みが完了する、もしくはexit等で終了処理が発生するまでファイルを再び読み込む処理が発生する。

setup.shを実行し、作成されたstrace_*のファイルを確認し、readのシステムコールを確認して挙動を見てみると
8192byteごとにreadが呼ばれていることがわかる※shellによって挙動が異なる可能性がある

## strace_ascript_without_block.log
```
read(255, "#!/usr/bin/bash\necho \"1\"\necho \"2\"\necho \"3\"\necho \"4\"\necho \"5\"\necho \"6\"\necho \"7\"\necho \"8\"\necho \"9\"\necho \"10\"\necho \"11\"\necho \"12\"\necho \"13\"\necho \"14\"\necho \"15\"\necho \"16\"\necho \"17\"\necho \"18\"\necho \"19\"\necho \"20\"\necho \"21\"\necho \"22\"\necho \"23\"\necho \"24\"\necho \"25\"\necho \"26\"\necho \"27\"\necho \"28\"\necho \"29\"\necho \"30\"\necho \"31\"\necho \"32\"\necho \"33\"\necho \"34\"\necho \"35\"\necho \"36\"\necho \"37\"\necho \"38\"\necho \"39\"\necho \"40\"\necho \"41\"\necho \"42\"\necho \"43\"\necho \"44\"\necho \"45\"\necho \"46\"\necho \"47\"\necho \"48\"\necho \"49\"\necho \"50\"\necho \"51\"\necho \"52\"\necho \"53\"\necho \"54\"\necho \"55\"\necho \"56\"\necho \"57\"\necho \"58\"\necho \"59\"\necho \"60\"\necho \"61\"\necho \"62\"\necho \"63\"\necho \"64\"\necho \"65\"\necho \"66\"\necho \"67\"\necho \"68\"\necho \"69\"\necho \"70\"\necho \"71\"\necho \"72\"\necho \"73\"\necho \"74\"\necho \"75\"\necho \"76\"\necho \"77\"\necho \"78\"\necho \"79\"\necho \"80\"\necho \"81\"\necho \"82\"\necho \"83\"\necho \"84\"\necho \"85\"\necho \"86\"\necho \"87\"\necho \"88\"\necho \"89\"\necho \"90\"\necho \"91\"\necho \"92\"\necho \"93\"\necho \"94\"\necho \"95\"\necho \"96\"\necho \"97\"\necho \"98\"\necho \"99\"\necho \"100\"\necho \"101\"\necho \"102\"\necho \"103\"\necho \"104\"\necho \"105\"\necho \"106\"\necho \"107\"\necho \"108\"\necho \"109\"\necho \"110\"\necho \"111\"\necho \"112\"\necho \"113\"\necho \"114\"\necho \"115\"\necho \"116\"\necho \"117\"\necho \"118\"\necho \"119\"\necho \"120\"\necho \"121\"\necho \"122\"\necho \"123\"\necho \"124\"\necho \"125\"\necho \"126\"\necho \"127\"\necho \"128\"\necho \"129\"\necho \"130\"\necho \"131\"\necho \"132\"\necho \"133\"\necho \"134\"\necho \"135\"\necho \"136\"\necho \"137\"\necho \"138\"\necho \"139\"\necho \"140\"\necho \"141\"\necho \"142\"\necho \"143\"\necho \"144\"\necho \"145\"\necho \"146\"\necho \"147\"\necho \"148\"\necho \"149\"\necho \"150\"\necho \"151\"\necho \"152\"\necho \"153\"\necho \"154\"\necho \"155\"\necho \"156\"\necho \"157\"\necho \"158\"\necho \"159\"\necho \"160\"\necho \"161\"\necho \"162\"\necho \"163\"\necho \"164\"\necho \"165\"\necho \"166\"\necho \"167\"\necho \"168\"\necho \"169\"\necho \"170\"\necho \"171\"\necho \"172\"\necho \"173\"\necho \"174\"\necho \"175\"\necho \"176\"\necho \"177\"\necho \"178\"\necho \"179\"\necho \"180\"\necho \"181\"\necho \"182\"\necho \"183\"\necho \"184\"\necho \"185\"\necho \"186\"\necho \"187\"\necho \"188\"\necho \"189\"\necho \"190\"\nec"..., 8192) = 8192
fstat(1, {st_mode=S_IFCHR|0666, st_rdev=makedev(0x1, 0x3), ...}) = 0
ioctl(1, TCGETS, 0x7fffe5530370)        = -1 ENOTTY (デバイスに対する不適切なioctlです)
write(1, "1\n", 2)                      = 2
write(1, "753\n", 4)                    = 4
read(255, "cho \"754\"\necho \"755\"\necho \"756\"\necho \"757\"\necho \"758\"\necho \"759\"\necho \"760\"\necho \"761\"\necho \"762\"\necho \"763\"\necho \"764\"\necho \"765\"\necho \"766\"\necho \"767\"\necho \"768\"\necho \"769\"\necho \"770\"\necho \"771\"\necho \"772\"\necho \"773\"\necho \"774\"\necho \"775\"\necho \"776\"\necho \"777\"\necho \"778\"\necho \"779\"\necho \"780\"\necho \"781\"\necho \"782\"\necho \"783\"\necho \"784\"\necho \"785\"\necho \"786\"\necho \"787\"\necho \"788\"\necho \"789\"\necho \"790\"\necho \"791\"\necho \"792\"\necho \"793\"\necho \"794\"\necho \"795\"\necho \"796\"\necho \"797\"\necho \"798\"\necho \"799\"\necho \"800\"\necho \"801\"\necho \"802\"\necho \"803\"\necho \"804\"\necho \"805\"\necho \"806\"\necho \"807\"\necho \"808\"\necho \"809\"\necho \"810\"\necho \"811\"\necho \"812\"\necho \"813\"\necho \"814\"\necho \"815\"\necho \"816\"\necho \"817\"\necho \"818\"\necho \"819\"\necho \"820\"\necho \"821\"\necho \"822\"\necho \"823\"\necho \"824\"\necho \"825\"\necho \"826\"\necho \"827\"\necho \"828\"\necho \"829\"\necho \"830\"\necho \"831\"\necho \"832\"\necho \"833\"\necho \"834\"\necho \"835\"\necho \"836\"\necho \"837\"\necho \"838\"\necho \"839\"\necho \"840\"\necho \"841\"\necho \"842\"\necho \"843\"\necho \"844\"\necho \"845\"\necho \"846\"\necho \"847\"\necho \"848\"\necho \"849\"\necho \"850\"\necho \"851\"\necho \"852\"\necho \"853\"\necho \"854\"\necho \"855\"\necho \"856\"\necho \"857\"\necho \"858\"\necho \"859\"\necho \"860\"\necho \"861\"\necho \"862\"\necho \"863\"\necho \"864\"\necho \"865\"\necho \"866\"\necho \"867\"\necho \"868\"\necho \"869\"\necho \"870\"\necho \"871\"\necho \"872\"\necho \"873\"\necho \"874\"\necho \"875\"\necho \"876\"\necho \"877\"\necho \"878\"\necho \"879\"\necho \"880\"\necho \"881\"\necho \"882\"\necho \"883\"\necho \"884\"\necho \"885\"\necho \"886\"\necho \"887\"\necho \"888\"\necho \"889\"\necho \"890\"\necho \"891\"\necho \"892\"\necho \"893\"\necho \"894\"\necho \"895\"\necho \"896\"\necho \"897\"\necho \"898\"\necho \"899\"\necho \"900\"\necho \"901\"\necho \"902\"\necho \"903\"\necho \"904\"\necho \"905\"\necho \"906\"\necho \"907\"\necho \"908\"\necho \"909\"\necho \"910\"\necho \"911\"\necho \"912\"\necho \"913\"\necho \"914\"\necho \"915\"\necho \"916\"\necho \"917\"\necho \"918\"\necho \"919\"\necho \"920\"\necho \"921\"\necho \"922\"\necho \"923\"\necho \"924\"\necho \"925\"\necho \"926\"\necho \"927\"\necho \"928\"\necho \"929\"\necho \"930\"\necho \"931\"\necho \"932\"\necho \"933\"\necho \"934\"\necho \"935\""..., 8192) = 8192
write(1, "754\n", 4)                    = 4
```

# 対策案1

意図しない読み込みを行うのは、同じinodeのファイルを上書きした場合になるので、  
cpコマンドでコピーしない、rsyncを使う。  
inodeはlsに-iオプションをつけると確認できる。

# 対策案2

スクリプトをブロックで囲み、全ての処理をメモリ上においてから実行する。  
bash 5.0.17(1)-release で試したところ、あまりコード量が多いとSegmentation fault となっていた。

https://stackoverflow.com/questions/21096478/overwrite-executing-bash-script-files  
https://craftsman-software.com/posts/62
