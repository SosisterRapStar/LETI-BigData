LOCAL_WORKER_THREADS := 2
CLUSTER_WORKER_NODES_NUM := 3

LOCAL_SPARK_JOB_NAME := spark-job-local
LOCAL_SPARK_CLUSTER_JOB_NAME := spark-job-local-cluster

SPARK_SCRIPT_FILE_NAME := spark_simple.py
SPARK_LOCAL_DIR := ~/apps
SPARK_SCRIPT_FILE_PATH := $(shell pwd)/$(SPARK_SCRIPT_FILE_NAME)
.ONESHELL:
SPARK_CLUSTER_ADDR := "spark://localhost:7077"

# start-spark-standalone-cluster:
	
spark-sub-local:
	@cd $(SPARK_LOCAL_DIR)/spark-4.0.0-bin-hadoop3
	@./bin/spark-submit --master "local[4]" --name $(LOCAL_SPARK_JOB_NAME) $(SPARK_SCRIPT_FILE_PATH)


spark-sub-cluster:
	@cd $(SPARK_LOCAL_DIR)/spark-4.0.0-bin-hadoop3
	@./bin/spark-submit --master $(SPARK_CLUSTER_ADDR) --name $(LOCAL_SPARK_CLUSTER_JOB_NAME) $(SPARK_SCRIPT_FILE_PATH) 

	
spark-sub-local:
	@cd $(SPARK_LOCAL_DIR)/spark-4.0.0-bin-hadoop3
	@./bin/spark-submit --master "" --name $(LOCAL_SPARK_JOB_NAME) $(SPARK_SCRIPT_FILE_PATH)


compose-down:
	@docker compose down

spark-cluster: compose-down
	@docker compose up -d

spark-cluster-scaled: compose-down
	@docker compose up --scale spark-worker=$(CLUSTER_WORKER_NODES_NUM) -d

.PHONY: spark-sub spark-sub-cluster