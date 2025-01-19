Proiect Cloud Computing

Olteanu Alexandru
Pescaru Andra
Brinzan Darius

Clusterul a fost simulat cu minikube cu engine docker. Am ridicat un control plane node si 2 worker nodes.

In total avem 5 microservicii ce tin de aplicatie de Backend scris in Spring.

Pentru fiecare microserviciu, am builduit cu maven proiectul de spring pentru a ne rezulta un .jar file. Ulterior am facut un Dockerfile similar pentru fiecare microserviciu, unde am builduit o imagine pentru a o folosi in deployment file din K8s. Inainte de acest pas, din cauza faptului ca imaginile de pe masina locala nu sunt accesibile clusterului, a fost nevoie sa le urcam pe toate in registry-ul local al clusterului de minikube.

Deployment-ul a fost initial facut cu fisierele manifest yaml, ulterior am observat ca infrastructura necesita a fi creata cu Terraform, astfel am creat si fisiere de deployment care utilizeaza HCL. Datorita faptului ca nu am dorit sa mai stricam infrastructura (ea fiind destul de instabila datorita resurselor limitate de pe laptop), am testat doar un microserviciu cu terraform care a si functionat. Daca incercam sa recreeam infrastructura deja existenta cu terraform, vom avea erori deoarece statefile-ul pentru terraform nu exista datorita faptului ca deployment-ul a fost facut cu fisiere manifest .yaml. Ca si structura la terraform, pentru fiecare microserviciu am initializat cu terraform init, o infrastructura locala.

Pentru partea de baze de date, am creat un pvc care a fost binded la un pv, pentru a mentine datele nealterate din baza de date si in acelasi timp, sa fie persistente.

Pentru vizualizarea de DB am deployat utilizand un Helm chart o imagine de Adminer. Acelasi lucru l-am folosit si pentru deployment-ul de Prometheus, Loki si Grafana. Am preluat un helm repository unde am gasit un chart cu ce ne trebuia noua si ulterior l-am modificat dupa necesitatile noastre.

Pentru fiecare microserviciu in parte, am creat un deployment file si un service file. Unele service-uri au fost de tip clusterip, dar unele precum adminer au fost asignate ca si NodePort sa fie accesibile direct din browserul local al masinii noastre.

Pentru separare si ordine, am creat un namespace pentru aplicatie, unul pentru monitoring si unul pentru partea de Adminer. 

Am deployat la fel, tot cu Helm o imagine de Portainer ca si tool de vizualizare a clusterului. Am facut si lucrul acesta chiar daca setupul nostru a fost facut pe OpenLens (varianta free a lui Lens), pentru a ne usura in a interactiona cu clusterul precum si vizualizarea log-urilor din pod-uri. Pe partea aceasta de Openlens, am preluat kubeconfig-ul din .kube/config de pe masina locala si am adaugat clusterul de minikube direct in aplicatie. Cu ajutorul acesteia, direct din UI am putut modifica direct fisierele manifest fara a mai face deployment din VScode.

Cu helm, am folosit chart-uri de Loki, Grafana si Prometheus pentru colectare de metrici si log-uri de la baza de date / microserviciile din cadrul proiectului.

http://prometheus-kube-prometheus-prometheus.monitoring.svc.cluster.local:9090

ID: 1860
Nume: Prometheus 2.0 Overview