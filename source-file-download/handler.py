import boto3
import logging
import os
import subprocess
import tempfile
import zipfile

logging.getLogger().setLevel("INFO")


def handler(event, context):
    temp_dir = tempfile.mkdtemp()

    subprocess.run(['kaggle', 'datasets', 'download', 'shivamb/netflix-shows', '--path', temp_dir],
                   stdout=subprocess.PIPE,
                   universal_newlines=True)

    with zipfile.ZipFile(f"{temp_dir}/netflix-shows.zip", 'r') as source_file_zip:
        source_file_zip.extractall(temp_dir)
        source_file_csv = [file for file in os.listdir(
            temp_dir) if ".csv" in file]
        print(source_file_csv)
        _upload_source_data_to_s3(source_file_csv[0])


def _upload_source_data_to_s3(source_file_csv: str):
    s3 = boto3.resource('s3')
    s3.Bucket(os.environ["source_bucket"]).upload_file(
        source_file_csv, "netflix.csv")
