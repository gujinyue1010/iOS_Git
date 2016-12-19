//
//  ViewController.swift
//  iOS系统学习-Git教程
//
//  Created by NetEase on 16/11/25.
//  Copyright © 2016年 NetEase. All rights reserved.
//
/*
 1.Git是分布式版本控制系统。(SVN是目前用得最多的集中式版本控制系统)
   . 分布式版本控制系统没有"中央服务器",每个人的电脑上都是一个完整的版本库。
   . 分布式版本控制系统通常也有一台充当"中央服务器"的电脑，但是这个服务器的作用仅仅是用来方便"交换"大家的修改。
 
 2.要使用Git,第一步就是安装Git。那么如何在Mac OS X上安装Git呢？
   1) 安装homebrew，然后通过homebrew安装Git。http://brew.sh/
   2) 推荐: 安装Xcode,Xcode集成了Git,不过默认没有安装。(打开Xcode->Preferences->Downloads->Command Line Tools,点击install安装即可)。
   ==>注意: Mac用户下载Xcode7.0以后的版本默认安装Git。
 
   3) 因为Git是分布式版本控制系统,所以每个机器都要自报家门:你的名字和Email地址。
      git config --global user.name  "Your name"
      git config --global user.email "email@example.com"
   ==>注意: git config命令的--global参数,表示这台机器上所有的Git仓库都会使用这个配置。
 
 3.创建版本库。
   1) 版本库又名仓库(repository)。可以理解为一个目录,目录里的所有文件都可以被Git管理起来。每个文件的修改、删除,Git都能追踪。以便任何时刻都可以追踪历史,或者在将来某个时刻还原。
 
   2) 创建一个版本库:
      (1)选择一个合适的地方,创建一个空目录。
          mkdir learngit
          cd learngit
          pwd:用于显示当前目录 /Users/michael/learngit
 
      (2)通过git init命令把这个目录变成Git可以管理的仓库。
          git init //Initialized empty Git repository in /Users/michael/learngit/.git/
   ==>这样Git就把仓库建好了,而且告诉你是一个空的仓库。(empty Git repository)。发现当前目录下多了一个.git目录。这个目录是Git用来追踪管理版本库的。如果你没有看到这个.git目录,是因为它默认隐藏的,用ls -ah命令就可以看见。
   ==>所有的版本控制系统包括Git,其实都只能追踪文件的改动,比如TxT文件,网页,所有的程序代码等.而图片、视频这些二进制文件,虽然能管理,但是没办法追踪文件的变化,也就是说到底改了啥,版本控制系统不知道。
 
      (3)现在在仓库里创建一个readme.txt文件。随便写一些内容。
         然后: git add readme.txt
              git commit -m "add a readme.txt" //把文件提交到仓库
 
   ==>为什么Git添加文件需要2步？
        1.可以通过git add多次添加不同文件。
        2.git commit -m " " 可以一次提交很多文件。//-m " " 输入的是本次提交的说明。
   ==>使用git status 可以让我们时刻掌握仓库当前的状态。
      使用git diff   可以让我们看到当前修改了什么(能够与没修改前比较)
      视同git diff readme.txt 查看单个文件的修改
   ==>提交修改和提交新文件是一样的。都需要先add再commit。
   ==>git的分支必须指向一个commit,没有任何commit就没有任何分支。提交第一个commit后自动创建分支。
 
      (4)版本回退: 当你提交了多次修改之后,突然发现修改出错,想要回退。
         1.使用 git log 可以查看历史提交记录。显示从最近到最远的提交日志。(git log --pretty=oneline)
         2.版本回退。
             git reset --hard HEAD^
             或者
             git reset --hard ??  ??代表提交日志中的commit id。
   ==>注意: 如果回退版本了,突然又发现不需要回退了。如果命令行窗口还没关掉,能够找到想要的版本的commit id,还是可以回去的。如果命令行窗口掉了,也是有后悔药可以吃的,利用git reflog 查看每一次命令。
       也即: git log 可以查看提交历史,决定回退到哪个版本。(git log --pretty=oneline)
            git reflog 可以查看命令历史,决定回到未来哪个版本。
 
 4.工作区和暂存区。
   1) 工作区。就是在电脑里能看到的目录。工作区有一个隐藏目录.git,这个不算工作区,而是Git的版本库。
   2) Git的版本库里存了很多东西,其中最重要的就是称为stage(或者叫index)的暂存区,还有Git为我们自动创建的第一个分支master,以及指向master的一个指针叫HEAD。
 
   3) 我们创建Git版本库时,Git自动为我们创建了唯一一个master分支。所以git commit就是往master分支上提交更改。可以简单理解为:需要提交的文件修改通通放到暂存区,然后一次性提交暂存区的所有修改。
      . 实际上git add 命令就是把需要提交的所有修改放到暂存区(Stage)。相当于购物车,可以清点买了哪些东西,清点完之后,commit相当于付款了。
      . 当多个文件修改完成放入暂存区的时候,发现其中一个文件的代码有问题,这时候需要用checkout单独将这个文件还原重改。
 
      . git diff 是工作区与暂存区的比较。
      . git diff --cached 是暂存区与master(最近一次提交)的比较。
 
 5.管理修改。注意工作区,暂存区,master分支最新的差别。
     (1)比如增加文件a，add了，这个时候工作区，暂存区都有这个文件a，但是master里是没有的。
     (2)再增加文件b，但是不add。这个时候工作区有a，b。暂存区有a，master都没有。
     (3)这个时候直接commit,工作区有a，b，暂存区空了，master有a。(可以 git status看看,发现工作区的b文件确实没有被提交)
 
 6.撤销修改。git checkout -- file 可以丢弃工作区的修改。
   分两种情况:
     (1)file自修改后还没有被放到暂存区。现在，撤销修改就回到和版本库一模一样的状态。
     (2)file的修改已经提交到暂存区,又做了修改。现在撤销修改就是回到添加到暂存区后的状态。
   ==>总之就是让文件回到最近一次 git commit 或者 git add 时的状态。
   ==>注意: -- 没有，git checkout dev2.1.0 变成了切换分支了。
 
     (3)file的修改已经add到暂存区，但是这个修改不想要了，要撤回。
        git reset HEAD file 可以把暂存区的修改撤销掉,重新回到工作区。这时候再git status会发现不想提交的东西还在，可以使用git checkout -- file撤销，相当于第(1)种情况。
   ==> git reset 命令既可以回退版本，也可以把暂存区的修改撤销掉，重新回到工作区。
       HEAD 表示最新的版本。
 
     (4)现在假设你不但改错了东西，还从暂存区提交到了版本库。可以回退到上一个版本。
        不过这是有条件的,就是还没有把自己的本地版本库推送到远程。
 
 7.删除文件。在Git中,删除也是一个修改操作。
   比如:1.先添加一个新文件test.txt
         然后通过 git add test.txt
                git commit -m "add test.txt"
         将其被Git管理。
       2.然后通过 rm test.txt 删除文件。(直接在文件管理器中把test.txt删除了)
         这个时候Git就知道哪个文件被删除了。通过Git status查看。
 
       3.现在有两个选择。
         (1)确实要从版本库中删除该文件。
            git rm 删掉
            git commit
         (2)删错了。因为版本库里还有呢。
            git checkout -- test.txt
 
    ==> git checkout 其实是用版本库的版本替换工作区的版本。无论工作区是修改还是删除,都可以一键还原。
 
***************************************************************************************************
***************************************************************************************************
 
 8.远程仓库。
   1) 上面7条已经让我们能够在Git仓库里,对文件进行各种操作了。也不用害怕出错了。
   2) 那以上7条其实在集中式版本控制系统比如SVN里,早就已经有了。如果只是在一个仓库里管理文件历史,Git和SVN真没啥区别。
   
   !!!
   3) Git是一个分布式版本控制系统。同一个仓库,可以分布到不同的机器上。早先只有一台机器有一个原始版本库,然后别的机器可以clone这个原始版本库,而且每台机器上的版本库其实都是一样的,并 没 有 主 次 之 分。
   ==>实际情况是找一台电脑充当服务器的角色。其他人都从这个服务器仓库clone一份到自己的电脑上,并且各自把提交推送到服务器仓库里,也可以从服务器仓库中拉取别人的提交。
   ==>我们完全可以自己搭一个运行Git的服务器,不过可以使用GitHub这个网站。GitHub网站是提供Git仓库托管服务的。只要注册一个GitHub账号,就可以免费获得Git远程仓库。
 
   4) 由于本地Git仓库和GitHub仓库之间的传输是通过SSH加密传输的,所以需要设置:
      (1)第一步: 创建SSH Key。在用户主目录下(注意是隐藏文件),看看有没有.ssh目录。如果有,再看看这个目录下有没有 id_rsa和id_rsa.pub这两个文件。如果已经有了,OK。如果没有,那就要创建SSH Key了。
 
         ssh-keygen -t rsa -C "youremail@example.com"
         需要把邮件地址换成自己自己的邮件地址,然后一路回车,使用默认值即可。
 
      (2)第二步: 如果一切顺利的话,可以在用户的主目录里找到.ssh目录,目录里有id_rsa和id_rsa.pub两个文件,这两个就是SSH Key的秘钥对。id_rsa是私钥,不能泄露。id_rsa.pub是公钥,可以告诉别人。
 
         //cat 拖路径 在terminal中打开得到。
         //pbcopy < ~/.ssh/id_rsa.pub 可以直接拷贝公钥内容
      
      (3)第三步: 登录GitHub,打开"Account settings","SSH Keys"页面。点击Add SSH Key,填上任意title,在Key文本框里粘贴id_rsa.pub文件的内容。
 
         ==>为什么GitHub需要SSH Key呢？因为GitHub需要识别出你推送的提交确实是你的,而不是别人冒充的。而Git支持SSH协议。所以GitHub只要知道你的公钥,就可以确认只有你才能推送。
         ==>GitHub允许添加多个Key。假如你有若干台电脑,你可以用一台电脑在公司提交,一台电脑在家里提交。只要把每台电脑的Key都添加到GitHub即可。
         ==>在GitHub上免费托管的Git仓库,任何人都可以看到。但是只有自己可以修改。如果不想让别人看到,可以交点钱变成private,或者自己搭建Git服务器。
 
 9.添加远程库。
   现在的情景是: 你已经在本地建好了一个Git仓库。又想在GitHub上创建一个仓库。并且这两个仓库进行远程同步。这样GitHub上的仓库既可以作为备份,又可以让其他人通过该仓库协作。
   (1)登录GitHub,在右上角"Create a new repo",创建一个新的仓库。输入repository name。其他保持默认设置。点击create repository按钮即可。
   (2)目前GitHub上的仓库还是空的。我们可以将其与一个已有的本地仓库与之关联。然后把本地的内容推送到GitHub仓库。
 
   (3).git remote add origin https://github.com/gujinyue1010/GitTestGujinyue.git
       添加后,远程库的名字就是origin。这是Git默认的叫法,也可以改成别的。
      .git push -u origin master
       把本地库的内容推送到远程库上。
   ==> 由于远程库是空的,所以我们第一次推送master分支时,加上-u参数,Git不但会把本地的master分支内容推送到远程新的master分支,还会把本地的master分支和远程的master分支关联起来。在以后的推送或者拉取中就可以简化命令。
      .从现在起,只要本地作了修改,就可以通过命令：git push origin master 把本地master分支的最新修改推送到GitHub上。你就拥有了真正的分布式版本库!
   ==>分布式版本系统最大的好处之一就是: 在本地工作完全不要考虑远程版本库的存在。只要在某时刻把本地提交推送一下就完成了同步。
 
 10.从远程库克隆。
    上面讲了先有版本库,后有远程库,如何关联远程库。
    现在我们从零出发。那么最好的方式就是先创建远程库。然后,从远程库克隆。
    (1) 登录GitHub。创建一个新的仓库,名字叫Gitskills。勾选Initialize this repository with a README,这样GitHub会自动为我们创建一个README.md文件。
    (2) 现在远程库准备好了,下一步是用命令 git clone 克隆一个版本库。
   ==>原始数据经过私钥加密后,只能使用公钥解密。换句话说,别人接收到经过加密的数据后,如果用你的公钥能够解密,那么就能确定这些数据是你发送的。
 
 11.分支管理。
    1) 创建与合并分支:
       (1) 在版本回退里,每次提交,Git都把它们串成一条时间线。这条时间线就是一个分支。截止到目前,只有一条时间线,在Git里,这个分支叫主分支,即master分支。||每次提交,master分支都会向前移动一步。
       (2) 创建新的分支如dev时,Git新建了一个指针叫dev,指向master相同的提交。再把HEAD指向dev,就表示当前在dev分支上。接下来,对工作区的修改和提交就是针对dev分支了。比如新提交一次后,dev指针往前移动一步,而master指针不变。
       (3) 现在我们在dev上的工作完成了,就可以把dev合并到master。直接把master指向dev当前的提交,HEAD指向master即可。合并完分支后,甚至可以删除dev分支。删除dev分支就是把dev指针删掉。这样就只剩下master分支了。
 
       (4) 开始实战:
           .创建dev分支,然后切换到dev分支。 git checkout -b dev
            (git checkout 加上-b参数表示创建并切换,相当于 git branch dev, git checkout dev)
 
           .然后用git branch 命令查看当前分支。
            (git branch 命令会列出所有分支,当前分支前面会有一个*号)
 
           .然后我们就可以在dev分支上正常提交。
           
           .现在dev上的工作完成,我们就可以切换回master分支。把dev分支的工作成果合并到master上。
            git merge dev
            (git merge 命令用于合并指定分支到当前分支。合并后,master分支和dev分支的最新提交就一样了。)
 
           .合并完成后,我们就可以放心地删除dev分支了。git branch -d dev
            删除后,git branch 就会发现只剩下master分支了。
   ==> 因为创建、合并、删除分支非常快。所以Git鼓励使用分支完成某个任务,合并后再删除。这和直接在master上工作效果是一样的,但是更安全。
 
   ==> .查看分支:git branch
       .创建分支:git branch <name>
       .切换分支:git checkout <name>
       .创建+切换分支:git checkout -b <name>
       .合并某分支到当前分支:git merge <name>
       .删除分支: git branch -d <name>
 
   ==>如果创建了dev分支,要git push origin dev 把dev分支推送到远程。
 
   2) 解决冲突。
      .git log --graph --pretty=oneline 可以看到合并分支图。
      .当Git无法自动合并分支时,就必须首先解决冲突。解决冲突后,再提交,合并完成。
      .一般来说,开分支是为了开发新功能,所以解决冲突并且合并之后,就可以删除了。那如果还想在分支上继续做一些其他事情,可以把master合并到分支上,使得master和分支保持一致。
 
   3) 分支管理策略。
      在实际开发中,我们应该按照几个基本原则进行分支管理。
      (1) master分支应该是非常稳定的,也就是仅用来发布新版本的,平时不要在上面干活。
      (2) 干活都在分支上,测试OK后,合并到master。所以团队中每个人都在dev分支上干活,每个人都有自己的分支。
      (3) --no-ff 参数可以用普通模式合并,合并后的历史有分支,就能看出来曾经做过合并。而fast forward合并就看不出来曾经做过合并。
 
   4) Bug分支。
      情景: 你正在某分支上开发新功能,突然有个bug需要修复。那很自然就要另开一个分支来修复。但是当前分支上的工作你还没做完,不能提交。
      .git stash: 可以把当前工作现场"储藏起来",等以后恢复现场后继续工作。
      .再使用git stash查看工作区,就是干净的。我们就可以放心创建分支来修复bug了。当我们修复完bug后又要回到之前的分支继续开发任务了。
      .git stash list: 工作现场还在,Git把stash内容存在某个地方了,但是需要回复。
       (1)git stash apply,但是恢复后,stash内容并不删除,使用git stash drop来删除。
       (2)git stash pop。恢复的同事把stash内容也删除了。再用git stash list,就看不到任何stash内容了。
 
   5) Feature分支。
      情景: 在某分支上开发了一个新功能,然后 add, commit。然后切换回需要合并的master。但是突然说这个功能不要了。那么怎么删除呢？
      .git branch -d dev。Git会提示:dev分支还没有被合并,如果删除,将丢失修改。如果强行删除,使用 git branch -D dev。
 ==>删除远程分支: git push origin:[要删除的远程分支的名字]
 
   6) 多人协作。
      .当我们从远程仓库克隆时,实际上Git自动把本地的master分支和远程的master分支对应起来了。并且远程仓库的默认名称是:origin。
      .查看远程仓库的信息,git remote。 
       git remote -v 显示更详细的信息。显示了可以抓取和推送的origin地址。
 
      .推送分支:就是把该分支上的所有本地提交推送到远程库。
       (1)master分支是主分支。需要时刻与远程同步。
       (2)dev分支是开发分支,团队所有成员都在上面工作,所以也需要与远程同步。
       (3)bug分支只用于在本地修复bug,就没必要推送到远程了。
       (4)feature分支是否推送到远程,取决于你是否和你的小伙伴在上面合作开发。
 ==>在Git中,分支完全可以在本地自己藏着玩,是否推送,是心情而定。
      
      .假设某小伙伴从远程库clone时,默认情况下,只能看到本地的master分支。现在小伙伴要在dev分支上开发,就必须创建远程origin的dev分支到本地,于是就得用这个命令创建本地dev分支。
       git checkout -b dev origin/dev。
       这样就可以在dev上继续修改,然后,时不时地把dev分支push到远程。
      
      .如果没有指定本地dev分支到远程origin/dev分支的链接。
       git branch --set-upstream dev origin/dev
 
 ==> 多人协作的工作模式通常是这样的:
     1.git push origin branch-name 推送自己的修改。
     2.如果推送失败,则因为远程分支比你的本地 更 新,先git pull试图合并。
     3.如果合并有冲突,则解决冲突,并在本地提交。
     4.没有冲突或者解决掉冲突后,再用git push origin branch-name推送。
 
 小结:
     (1)查看远程库信息,使用 git remote -v
     (2)本地新建的分支如果不推送到远程,对其他人是不可见的。
     (3)从本地推送分支,使用git push origin branch-name。如果推送失败,先用git pull抓取远程的新提交。
     (4)在本地创建和远程分支对应的分支。git checkout -b branch-name origin/branch-name (本地和远程分支的名称最好一致)。
     (5)建立本地分支和远程分支的关联。git branch --set-upstream branch-name origin/branch-name。
     (6)从远程抓取分支,使用git pull。如果有冲突,要先处理冲突。
 
     (7)将本地分支作为新分支推送到远程。
        git push origin local_branch:remote_branch
        local_branc 必须是本地存在的分支。remote_branch为远程分支。如果remote_branch不存在则会自动创建分支。
     (8)删除远程分支。 git push origin --delete branch-name
 */
import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

