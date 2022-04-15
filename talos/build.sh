#!/bin/bash
talosctl gen config "main" "https://10.0.7.2:6443" --config-patch-control-plane @controlplane-patch.json 

# Cluster running using vCenter VMs for control plane nodes
talosctl apply-config -i -n 10.0.7.3 -f controlplane.yaml
talosctl apply-config -i -n 10.0.7.6 -f controlplane.yaml
talosctl apply-config -i -n 10.0.7.7 -f controlplane.yaml

talosctl --talosconfig=./talosconfig config endpoint 10.0.7.3 10.0.7.6 10.0.7.7
talosctl config merge ./talosconfig

# It will take a few minutes for the nodes to spin up with the configuration.  Once ready, execute
# talosctl bootstrap -n 10.0.40.16

# It will then take a few more minutes for Kubernetes to get up and running on the nodes. Once ready, execute
# talosctl kubeconfig -n 10.0.40.16
