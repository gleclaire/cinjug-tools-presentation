
from diagrams import Cluster, Diagram
from diagrams.aws.compute import ECS, EC2
from diagrams.aws.database import ElastiCache, RDS
from diagrams.aws.network import ELB, Route53, NLB


graph_attr = {
    "fontsize": "45",
    "bgcolor": "transparent"
}

node_attr = {
    "fontsize": "12",
    "fillcolor": "green",
    "fontcolor": "red"
}

with Diagram("Development Environment", show=False, graph_attr=graph_attr, node_attr=node_attr, direction="TB"):
    global_dns = Route53("Global DNS \n dev.example.com")
    aws_dns = Route53("AWS DNS \n dev.aws-example.net")
    lb = ELB("ALB \n *.dev.example.com")

    with Cluster("Services"):
        svc_group = [ECS("UI App"),
                     ECS("Backend")]

    with Cluster("DB Cluster"):
        db_master = RDS("dev DB")

    memcached = ElastiCache("RedisCache")

    global_dns >> aws_dns >> lb >> svc_group
    svc_group >> db_master
    svc_group >> memcached
