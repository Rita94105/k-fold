# k*-fold cross-validation in protein subcellular localization
![PredictProtein](/images/img1.png)

## Description
Perform *k*-fold cross-validation for tuning the following parameters of a random forest model.
  * ntree: 10
  * mtry: 75
  * maxnodes: 20

### cmd
```R
k_fold(k, './data/Archaeal_tfpssm.csv', 'performance.csv')
```

### *k*-fold cross-validation
* Divide the data into *k* parts, the number of parts used by each data set
  * (training, validation, testing) = (*k*-2, 1, 1)
* The following shows the example of the 5-fold cross validation.

<br> 

![cross-validation](/images/img2.png)

### Input: Archaeal_tfpssm.csv

[📁 Archaeal_tfpssm.csv download](https://drive.google.com/file/d/1N99q71GckX0lzxCqpcGUStke3iNv__nG/view?usp=sharing)

This CSV doesn't contain a header. The information of columns as below:

* `V2`: labels of proteins
  * CP: Cytoplasmic
  * CW: Cell Wall
  * EC: Extracellular
  * IM: Inner membrane

* `V3 ~ V5602`: the gapped-dipeptide features of each protein

### Output format: performance.csv

* accuracy = *P*/*N*, average of *k*-fold cross-validation

set|training|validation|test
---|---|---|---
fold1|0.93|0.91|0.88
fold2|0.92|0.91|0.89
fold3|0.94|0.92|0.90
fold4|0.91|0.89|0.87
fold5|0.90|0.92|0.87
ave.|0.92|0.91|0.88


### Code for reference

```R
library(randomForest)

k_fold <- function(fold, input_file, output_file){
  
  # model using random forest & tune best parameters
  model <- randomForest(ntree, mtry, maxnodes)
  # make confusion matrix tabel
  resultframe <- data.frame(truth=tmp$V2,
                            pred=predict(model, type="class"))
  # output the confusion matrix                        
  write.csv()

  return (your_model)
}
```

## References
Please list the code and its reference.

If needed, you should explain the details, i.e., comment like # ChatGPT, respond to “your prompt,” February 16, 2023.

Data Set:
* Chang, J.-M. M. et al. (2013) [Efficient and interpretable prediction of protein functional classes by correspondence analysis and compact set relations](https://journals.plos.org/plosone/article?id=10.1371/journal.pone.0075542). *PLoS ONE* 8, e75542.
* Chang J-M, Su EC-Y, Lo A, Chiu H-S, Sung T-Y, & Hsu W-L (2008) [PSLDoc: Protein subcellular localization prediction based on gapped-dipeptides and probabilistic latent semantic analysis](https://onlinelibrary.wiley.com/doi/full/10.1002/prot.21944). *Proteins: Structure, Function, and Bioinformatics* 72(2):693-710.

Code:
- [Practical Random Forest and repeated cross validation in R](https://rpubs.com/jvaldeleon/forest_repeat_cv)
- [隨機森林 (Random Forest)](https://rpubs.com/jiankaiwang/rf)
- [Random Forest prediction model in R](https://rpubs.com/markloessi/498787)
- [Simple examples of cross-validation](https://rpubs.com/muxicheng/1004550)
- [Day 23. (分類、回歸) 隨機森林 Random forest](https://ithelp.ithome.com.tw/articles/10303882?sc=rss.qu)
