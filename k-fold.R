library(randomForest)

k_fold <- function(fold, input_file, output_file){
  data<- subset(read.csv(input_file, header = FALSE, sep = ","), select = c(1: 5602))
  
  result <- data.frame(set = character(),
                       train = numeric(),
                       validation = numeric(),
                       test = numeric())
  
  folds <- split(data, 1:fold)
  
  for( i in 1 : fold){
    test <- folds[[i]]
    vali <- folds[[(i %% fold) + 1]]
    train_indices <- setdiff(1:fold, c(i, (i + 1) %% fold))
    train <- do.call(rbind, lapply(train_indices, function(idx) folds[[idx]]))
    model <- randomForest(formula = as.factor(V2) ~ .,
                          data = train,
                          ntree = 100,
                          mtry = 75,
                          maxnodes = 20)
    accuracy_train <- sum(diag(model$confusion)) / sum(model$confusion)
    
    pred <- predict(model, test)
    pred_cm <- table(observed = test[ , "V2"], predicted = pred)
    accurancy_pred <- sum(diag(pred_cm)) / sum(pred_cm)
    
    val <- predict(model, vali)
    val_cm <- table(observed = vali[, "V2"], predicted = val)
    accurancy_val <- sum(diag(val_cm)) / sum(val_cm)
    result <- rbind(result, data.frame(set = paste("fold",i,sep=""),
                                       train = round(accuracy_train, digits = 2),
                                       validation = round(accurancy_val, digits = 2), 
                                       test = round(accurancy_pred, digits = 2)))
  }
  
  result <- rbind(result, data.frame(set = "ave.",
                                     train = round(mean(result$train), digits =2),
                                     validation = round(mean(result$validation), digits =2),
                                     test = round(mean(result$test), digits = 2)))
  # print result in output file
  write.csv(result, output_file)
  
  model <- randomForest(formula = as.factor(V2) ~ .,
                        data = data,
                        ntree = 100,
                        mtry = 75,
                        maxnodes = 20)
  
  return (model)
}

preprocess <- function(input_file_path) {
  print("hello hidden data")
  data <- read.csv(input_file_path, header = FALSE)
}

#k_fold(5, './data/Archaeal_tfpssm.csv', 'performance.csv')
