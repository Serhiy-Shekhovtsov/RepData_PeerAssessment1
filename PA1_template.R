
# set working directory as folder of current file
file_path <- parent.frame(2)$ofile
setwd(dirname(file_path))

rds_file <- "Data\\Src\\activity.rds"
if (file.exists(rds_file)) {
	# load rds file
	data <- readRDS(rds_file)
} else {
	print("loading from archive")
	# extract archive
	temp_file_path <- unzip("activity.zip")
	
	data <- read.csv(temp_file_path)
	file.remove(temp_file_path)
	
	# save as RDS for fast reading in future
	saveRDS(data, rds_file)
}

str(data)
data$date <- as.Date(data$date, "%Y-%m-%d")
str(data)

total_steps_per_day = aggregate(steps~date, data=data, sum)
hist(total_steps_per_day$steps, breaks=nrow(total_steps_per_day), col="green")