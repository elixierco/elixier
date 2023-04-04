# vim: set filetype=python:

import datetime
from dateutil.parser import parse as parse_date
import pendulum
from airflow import DAG
from airflow.operators.python import PythonOperator
from airflow.decorators import task
import json

with DAG(
    dag_id="superset_saved_query_34",
    schedule="@daily",
    start_date=parse_date("2023-04-04T01:00:00.000Z"),
    end_date=parse_date("2023-05-03T01:00:00.000Z"),
    catchup=False,
    tags=['superset']) as dag:

   
    @task(task_id='execute_query')
    def execute_query(**kwargs):
        from sqlalchemy import create_engine
        from sqlalchemy import text

        connect_args = json.loads('{}')
        db_uri = json.loads('"trino://admin@elixier-trino:8080/hive/default"')
        sql = json.loads('"select * from demotable"')
        db_backend = json.loads('"trino"')
        output_table = json.loads('"mytable"')

        engine = create_engine(db_uri,  connect_args=connect_args)

        with engine.connect() as connection:
            if output_table:
                if db_backend in ['mysql','oracle','mariadb','postgresql']:
                    connection.execute(text("drop table if exists :output_table"), output_table=output_table)
                    connection.execute(text("create table :output_table as (%s)" % sql), output_table=output_table)
                else:
                    print("output_table is not supported in backend %s" % db_backend, file=sys.stderr)
            else:
                connection.execute(text(sql))

    