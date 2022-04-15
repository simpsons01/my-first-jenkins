## 連結
- [documentation](https://www.jenkins.io/doc/book/)
- [jenkins server](http://18.212.133.249:8080/)
- [test repo](https://github.com/simpsons01/project-for-cicd)
## 建議閱讀
- [jenkins 名詞介紹](https://www.jenkins.io/doc/book/glossary/)
- [更新commit status與觸發建置的方式](https://github.com/simpsons01/my-first-jenkins/wiki/%E6%AF%94%E8%BC%83jenkins%E6%9B%B4%E6%96%B0commit-status-%E8%88%87%E8%A7%B8%E7%99%BC%E5%BB%BA%E7%BD%AE%E7%9A%84%E6%96%B9%E5%BC%8F)
- [架構圖](https://github.com/simpsons01/my-first-jenkins/wiki/%E6%9E%B6%E6%A7%8B%E5%9C%96)

## Q&A
##### Q: Jenkins Controller與Agent的關係？
Ａ: Agent可以是一台機器, container，由Jenkins controller管理，主要職責是執行由Jenkins Controller委派的任務
##### Q: Jenkins Controller跟Agent目前是如何啟動的？
A: 兩者都是由docker啟動，並使用官方釋出image，參考[agent](https://hub.docker.com/r/jenkins/ssh-agent/)，[jenkins-controller](https://hub.docker.com/r/jenkins/jenkins)
##### Q:怎麼確保Jenkins跟Agent服務的穩定性？
A: Docker提供[restart policy](https://docs.docker.com/config/containers/start-containers-automatically/)，讓container如果因為容器內的行程(process)出現錯誤後導致container關閉後，可以自動重啟，使用`on-failure` policy，並設定`max-retries`為10次
##### Q: 如何處理備份？
A: Docker bind-mounts讓container可以與host共享檔案資料，因此當container被移除並重啟後，只有掛載同一個資料夾就可以取回已銷毀container的資料

## 待討論
- 需要撰寫哪些教學文件？
   - 如何撰寫Jenkinsfile
   - 如何新增部署流程需要的credentials
   - 如何新增agent
   - 待補充
- 參考這份比較([更新commit status與觸發建置的方式](https://github.com/simpsons01/my-first-jenkins/wiki/%E6%AF%94%E8%BC%83jenkins%E6%9B%B4%E6%96%B0commit-status-%E8%88%87%E8%A7%B8%E7%99%BC%E5%BB%BA%E7%BD%AE%E7%9A%84%E6%96%B9%E5%BC%8F))，要用什麼方式更新commit status與觸發建置的方式？
- 是否有需要研究在Jenkins如何管理使用者？
- 是否有需要研究Jenkins如何查看系統logs
- 待補充
