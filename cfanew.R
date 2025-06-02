CFA_rel_analysisV2 <- function(MV_lists, cfa.models, dati, estimator.used){
  reliability.table <- matrix(NA, nrow = length(MV_lists), ncol = 5)
  colnames(reliability.table) <- c("Alpha", "Lower IC", "Upper IC", "AVE", "Omega")
  rownames(reliability.table) <- names(MV_lists)
  
  # CORREZIONE: inizializza le liste con lunghezza corretta
  results.CFA <- vector("list", length(MV_lists))
  loadings.CFA <- vector("list", length(MV_lists))
  names(results.CFA) <- names(MV_lists)
  names(loadings.CFA) <- names(MV_lists)
  
  for (k in 1:length(MV_lists)){
    if (length(MV_lists[[k]]) < 2) { print ("only one indicator") }
    else {
      print(paste("Latent Variable:", names(MV_lists)[k]))
      corrplot.mixed(cor(dati[,MV_lists[[k]]]), upper = "ellipse") 
      CI.alpha <- MyAlpha.CI(as.matrix(dati[,MV_lists[[k]]]), sig=0.05)
      reliability.table[k, "Alpha"] <- round(CI.alpha$point.estimate, 3)
      reliability.table[k, "Lower IC"] <- round(CI.alpha$CI$lower.bound, 3)
      reliability.table[k, "Upper IC"] <- round(CI.alpha$CI$upper.bound, 3)
      
      if (length(MV_lists[[k]]) < 3) { print ("only two indicators, cannot calculate CFA") }
      else {
        fit <- lavaan::cfa(cfa.models[[k]], dati, estimator=estimator.used, std.lv=F)
        reliability.table[k, "AVE"] <- round(AVE(fit), 3)
        reliability.table[k, "Omega"] <- round(compRelSEM(fit), 3)
        results.CFA[[k]] <- fit
        loadings.CFA[[k]] <- parameterEstimates(fit)[parameterEstimates(fit)$op == "=~", ]
        rm(fit)
      }
      rm(CI.alpha)
    }
  }
  rm(k)
  return(list(results.CFA=results.CFA, loadings.CFA=loadings.CFA, reliability.table=reliability.table))
}
