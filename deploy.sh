#!/bin/bash

# نشر Deployment و Service
kubectl apply -f .

# انتظر 30 ثانية عشان البودات تشتغل
echo "Waiting 30 seconds for pods to be ready..."
sleep 30

# شوف أول بود جاهز
POD_NAME=$(kubectl get pods -l app=test-spring -o jsonpath='{.items[0].metadata.name}')
echo "Using pod: $POD_NAME"

# اعمل port-forward للبود في الخلفية
kubectl port-forward $POD_NAME 8081:8080 &
PF_PID=$!

# trap عشان يقفل تلقائي لو السكريبت وقف
trap "echo 'Stopping port-forward...'; kill $PF_PID" EXIT

# طبع رابط الوصول
echo "Access your app at: http://127.0.0.1:8081/actuator/health"

# لو عايز السكريبت ينتظر طول ما الـ port-forward شغال:
wait $PF_PID
