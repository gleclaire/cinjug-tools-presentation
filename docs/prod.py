




from diagrams import Cluster, Diagram, Edge
from diagrams.aws.compute import ECS
from diagrams.aws.database import ElastiCache, RDS
from diagrams.aws.network import ELB, Route53, NLB
from diagrams.generic.device import Mobile
from diagrams.onprem.client import Users
from diagrams.azure.web import AppServiceCertificates as Certificates

graph_attr = {
    "fontsize": "45",
    "bgcolor": "transparent"
}

node_attr = {
    "fontsize": "12",
    "fillcolor": "green",
    "fontcolor": "red"
}

with Diagram("Production Environment", show=False, graph_attr=graph_attr, node_attr=node_attr, direction="TB"):
    web_users = Users("Web Users")
    global_dns = Route53("Global DNS \n prod.example.com")
    aws_dns = Route53("AWS DNS \n prod.aws-example.net")
    web_nlb = NLB("NLB")
    web_certificate = Certificates("*.apps.example.com")
    web_alb = ELB("Web ALB")

    with Cluster("Web Training Cluster"):
        ui_svc_group = [ECS("Web UI App")]
        backend_svc_group = [ECS("Web Backend")]


    with Cluster("PSPSFKit Cluster"):
        pspdf_svc_group = ECS("PSPSFKit")

    prod_db = RDS("App DB")

    prod_cache = ElastiCache("Web App Cache")


    backend_svc_group >> prod_db
    backend_svc_group >> pspdf_svc_group
    backend_svc_group >> prod_cache

    web_alb >> ui_svc_group
    ui_svc_group >> prod_db
    ui_svc_group >> pspdf_svc_group

