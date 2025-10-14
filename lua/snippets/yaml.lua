local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local c = ls.choice_node
local fmt = require("luasnip.extras.fmt").fmt
local rep = require("luasnip.extras").rep

return {
  -- Kubernetes Deployment
  s("k8s-deployment", fmt([[
    apiVersion: apps/v1
    kind: Deployment
    metadata:
      name: {name}
      labels:
        app: {app}
    spec:
      replicas: {replicas}
      selector:
        matchLabels:
          app: {app}
      template:
        metadata:
          labels:
            app: {app}
        spec:
          containers:
          - name: {container_name}
            image: {image}
            ports:
            - containerPort: {port}
            env:
            - name: {env_name}
              value: "{env_value}"
  ]], {
    name = i(1, "my-app"),
    app = rep(1),
    replicas = i(2, "3"),
    container_name = rep(1),
    image = i(3, "nginx:latest"),
    port = i(4, "80"),
    env_name = i(5, "NODE_ENV"),
    env_value = i(0, "production")
  })),

  -- Kubernetes Service
  s("k8s-service", fmt([[
    apiVersion: v1
    kind: Service
    metadata:
      name: {name}
    spec:
      selector:
        app: {app}
      ports:
      - protocol: TCP
        port: {port}
        targetPort: {target_port}
      type: {service_type}
  ]], {
    name = i(1, "my-app-service"),
    app = i(2, "my-app"),
    port = i(3, "80"),
    target_port = i(4, "8080"),
    service_type = c(5, {t("ClusterIP"), t("NodePort"), t("LoadBalancer")})
  })),

  -- Kubernetes ConfigMap
  s("k8s-configmap", fmt([[
    apiVersion: v1
    kind: ConfigMap
    metadata:
      name: {name}
    data:
      {key}: |
        {value}
  ]], {
    name = i(1, "app-config"),
    key = i(2, "config.yaml"),
    value = i(0, "setting: value")
  })),

  -- Kubernetes Secret
  s("k8s-secret", fmt([[
    apiVersion: v1
    kind: Secret
    metadata:
      name: {name}
    type: Opaque
    data:
      {key}: {base64_value}
  ]], {
    name = i(1, "app-secret"),
    key = i(2, "password"),
    base64_value = i(0, "cGFzc3dvcmQ=")  -- base64 encoded 'password'
  })),

  -- Kubernetes Ingress
  s("k8s-ingress", fmt([[
    apiVersion: networking.k8s.io/v1
    kind: Ingress
    metadata:
      name: {name}
      annotations:
        nginx.ingress.kubernetes.io/rewrite-target: /
    spec:
      rules:
      - host: {host}
        http:
          paths:
          - path: {path}
            pathType: Prefix
            backend:
              service:
                name: {service_name}
                port:
                  number: {port}
  ]], {
    name = i(1, "app-ingress"),
    host = i(2, "myapp.example.com"),
    path = i(3, "/"),
    service_name = i(4, "my-app-service"),
    port = i(0, "80")
  })),

  -- Kubernetes PVC
  s("k8s-pvc", fmt([[
    apiVersion: v1
    kind: PersistentVolumeClaim
    metadata:
      name: {name}
    spec:
      accessModes:
      - ReadWriteOnce
      resources:
        requests:
          storage: {size}
      storageClassName: {storage_class}
  ]], {
    name = i(1, "app-storage"),
    size = i(2, "10Gi"),
    storage_class = i(0, "standard")
  })),

  -- Docker Compose service
  s("docker-compose", fmt([[
    version: '3.8'
    
    services:
      {service_name}:
        image: {image}
        ports:
          - "{host_port}:{container_port}"
        environment:
          - {env_var}={env_value}
        volumes:
          - {volume_mapping}
        depends_on:
          - {dependency}
        networks:
          - {network}
    
    networks:
      {network}:
        driver: bridge
    
    volumes:
      {volume_name}:
  ]], {
    service_name = i(1, "web"),
    image = i(2, "nginx:latest"),
    host_port = i(3, "8080"),
    container_port = i(4, "80"),
    env_var = i(5, "NODE_ENV"),
    env_value = i(6, "production"),
    volume_mapping = i(7, "./data:/data"),
    dependency = i(8, "db"),
    network = i(9, "app-network"),
    volume_name = i(0, "app-data")
  })),

  -- Helm Chart.yaml
  s("helm-chart", fmt([[
    apiVersion: v2
    name: {name}
    description: {description}
    type: application
    version: {chart_version}
    appVersion: "{app_version}"
    
    dependencies:
    - name: {dep_name}
      version: {dep_version}
      repository: {repository}
  ]], {
    name = i(1, "my-app"),
    description = i(2, "A Helm chart for my application"),
    chart_version = i(3, "0.1.0"),
    app_version = i(4, "1.0.0"),
    dep_name = i(5, "postgresql"),
    dep_version = i(6, "11.6.12"),
    repository = i(0, "https://charts.bitnami.com/bitnami")
  })),

  -- Helm values.yaml
  s("helm-values", fmt([[
    replicaCount: {replicas}
    
    image:
      repository: {repository}
      pullPolicy: {pull_policy}
      tag: "{tag}"
    
    service:
      type: {service_type}
      port: {port}
    
    ingress:
      enabled: {ingress_enabled}
      className: "{ingress_class}"
      annotations: {{}}
      hosts:
        - host: {host}
          paths:
            - path: /
              pathType: Prefix
    
    resources:
      limits:
        cpu: {cpu_limit}
        memory: {memory_limit}
      requests:
        cpu: {cpu_request}
        memory: {memory_request}
    
    autoscaling:
      enabled: {hpa_enabled}
      minReplicas: {min_replicas}
      maxReplicas: {max_replicas}
      targetCPUUtilizationPercentage: {cpu_percent}
  ]], {
    replicas = i(1, "3"),
    repository = i(2, "nginx"),
    pull_policy = c(3, {t("IfNotPresent"), t("Always"), t("Never")}),
    tag = i(4, "latest"),
    service_type = i(5, "ClusterIP"),
    port = i(6, "80"),
    ingress_enabled = c(7, {t("false"), t("true")}),
    ingress_class = i(8, "nginx"),
    host = i(9, "chart-example.local"),
    cpu_limit = i(10, "500m"),
    memory_limit = i(11, "512Mi"),
    cpu_request = i(12, "250m"),
    memory_request = i(13, "256Mi"),
    hpa_enabled = c(14, {t("false"), t("true")}),
    min_replicas = i(15, "1"),
    max_replicas = i(16, "10"),
    cpu_percent = i(0, "80")
  })),

  -- GitHub Actions workflow
  s("gh-actions", fmt([[
    name: {workflow_name}
    
    on:
      push:
        branches: [ {branch} ]
      pull_request:
        branches: [ {branch} ]
    
    jobs:
      {job_name}:
        runs-on: ubuntu-latest
        
        steps:
        - uses: actions/checkout@v3
        
        - name: {step_name}
          run: |
            {commands}
        
        - name: {test_step}
          run: |
            {test_commands}
  ]], {
    workflow_name = i(1, "CI"),
    branch = i(2, "main"),
    job_name = i(3, "test"),
    step_name = i(4, "Setup"),
    commands = i(5, "echo \"Setting up environment\""),
    test_step = i(6, "Run tests"),
    test_commands = i(0, "echo \"Running tests\"")
  })),

  -- Ansible playbook
  s("ansible", fmt([[
    ---
    - name: {playbook_name}
      hosts: {hosts}
      become: {become}
      
      vars:
        {var_name}: {var_value}
      
      tasks:
        - name: {task_name}
          {module}:
            {module_params}
          
        - name: {service_task}
          service:
            name: {service_name}
            state: started
            enabled: yes
  ]], {
    playbook_name = i(1, "Configure web servers"),
    hosts = i(2, "webservers"),
    become = c(3, {t("yes"), t("no")}),
    var_name = i(4, "nginx_port"),
    var_value = i(5, "80"),
    task_name = i(6, "Install nginx"),
    module = i(7, "package"),
    module_params = i(8, "name: nginx\n            state: present"),
    service_task = i(9, "Start nginx service"),
    service_name = i(0, "nginx")
  })),
}