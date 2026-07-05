# plclone

Despliegue automatizado de PLCs para simular escenarios de procesos industriales.
```
export $(xargs < .env) && ansible-playbook -i inventory.yml site.yml
```